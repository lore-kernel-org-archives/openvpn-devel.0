MIME-Version: 1.0
In-Reply-To: <55DDB89A.6030105@...1147...>
References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
	<55DDB89A.6030105@...1147...>
Date: Wed, 26 Aug 2015 12:51:13 -0300
Message-ID: <CAAWBBYNrHwpEyr9uhnOXebB2R4pufbXc0p5QhbhTFrdf=te8BA@...278...>
From: Rafael Gava <gava100@...277...>
Content-Type: multipart/alternative; boundary=001a113fd83af6592b051e38d1ac
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
	Translator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--001a113fd83af6592b051e38d1ac
Content-Type: text/plain; charset=UTF-8

Hi JJK,

"client-ip" instead of "localhost" sounds good to me.

BR

Gava

On Wed, Aug 26, 2015 at 10:01 AM, Jan Just Keijser <janjust@...1147...>
wrote:

> Hi,
>
> Rafael Gava wrote:
>
>>
>> this is my first submission to the list and I hope that I'm doing in the
>> right way. :-)
>>
>>
>> Well, the features added to Network Address Translator are:
>>
>> 1) Allow the user to use the string "localhost" on the client-nat network
>> configuration in a way that is not necessary to inform the IP address
>> beforehand. Openvpn will set the dynamic received IP from DHCP. Example:
>>
>> client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
>> 'localhost' string with the DHCP address received from openvpn server.
>>
>> I understand the idea behind it but it would be a NACK from me on the
> string "localhost" - to me, localhost is 127.0.0.1 or ::1, not the DHCP-IP
> ; perhaps use something like "client-ip"   ?
>
>
> 2) Allow the user to enable the FTP NAT support through the
>> --enable-nat-ftp-support option. This is useful for systems that don't have
>> conntrack-tools support, for example on Windows systems. On windows this
>> feature is enabled by default.
>>
>> enable-nat-ftp-support (yes | no)
>>
>> sounds like a useful feature to me.
>
>
> JJK
>
>
>> The following patch was written based on release/2.3 branch.
>>
>> --------------------------------------------------------------------------------------------------------------------------------------
>>
>> From d11957a025dc6c113874e7b04ce4c8e9513c3b02 Mon Sep 17 00:00:00 2001
>> From: venturus <venturus@...2055...(none)>
>> Date: Thu, 13 Aug 2015 08:26:36 -0300
>> Subject: [PATCH] Replaces the client-nat network string 'localhost' with
>> the
>>  dynamic IP set to the tun/tap interface by the openvpn
>>  server. Example:
>>
>> --client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
>> 'localhost' string with the DHCP address received from openvpn server.
>>
>> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>>
>> ---
>>  src/openvpn/clinat.c |   57
>> ++++++++++++++++++++++++++++++++++++++++++--------
>>  src/openvpn/clinat.h |    2 ++
>>  src/openvpn/init.c   |    4 ++++
>>  3 files changed, 54 insertions(+), 9 deletions(-)
>>  mode change 100644 => 100755 src/openvpn/clinat.c
>>  mode change 100644 => 100755 src/openvpn/clinat.h
>>  mode change 100644 => 100755 src/openvpn/init.c
>>
>> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
>> old mode 100644
>> new mode 100755
>> index af75fc9..2460185
>> --- a/src/openvpn/clinat.c
>> +++ b/src/openvpn/clinat.c
>> @@ -107,11 +107,11 @@ copy_client_nat_option_list (struct
>> client_nat_option_list *dest,
>>   void
>>  add_client_nat_to_option_list (struct client_nat_option_list *dest,
>> -      const char *type,
>> -      const char *network,
>> -      const char *netmask,
>> -      const char *foreign_network,
>> -      int msglevel)
>> +            const char *type,
>> +            const char *network,
>> +            const char *netmask,
>> +            const char *foreign_network,
>> +            int msglevel)
>>  {
>>    struct client_nat_entry e;
>>    bool ok;
>> @@ -126,12 +126,19 @@ add_client_nat_to_option_list (struct
>> client_nat_option_list *dest,
>>        return;
>>      }
>>  -  e.network = getaddr(0, network, 0, &ok, NULL);
>> -  if (!ok)
>> +  if (network && !strcmp(network, "localhost"))
>>      {
>> -      msg(msglevel, "client-nat: bad network: %s", network);
>> -      return;
>> +      msg (M_INFO, "*** client-nat localhost detected...");
>> +      e.network = 0xFFFFFFFF;
>> +    } else {
>> +      e.network = getaddr(0, network, 0, &ok, NULL);
>> +      if (!ok)
>> +      {
>> +        msg(msglevel, "client-nat: bad network: %s", network);
>> +        return;
>> +      }
>>      }
>> +       e.netmask = getaddr(0, netmask, 0, &ok, NULL);
>>    if (!ok)
>>      {
>> @@ -148,6 +155,7 @@ add_client_nat_to_option_list (struct
>> client_nat_option_list *dest,
>>    add_entry(dest, &e);
>>  }
>>  +
>>  #if 0
>>  static void
>>  print_checksum (struct openvpn_iphdr *iph, const char *prefix)
>> @@ -266,4 +274,35 @@ client_nat_transform (const struct
>> client_nat_option_list *list,
>>      }
>>  }
>>  +/*
>> +* Replaces the localhost token with the IP received from OpenVPN
>> +*/
>> +bool +update_localhost_nat(struct client_nat_option_list *dest,
>> in_addr_t local_ip)
>> +{
>> +  int i;
>> +  bool ret = false;
>> +
>> +  if (!dest)
>> +    return ret;
>> +
>> +  for (i=0; i <= dest->n; i++) +    {
>> +      struct client_nat_entry *nat_entry = &dest->entries[i];
>> +      if (nat_entry && nat_entry->network == 0xFFFFFFFF) +        {
>> +          struct in_addr addr;
>> +          +          nat_entry->network = ntohl(local_ip);
>> +          addr.s_addr = nat_entry->network;
>> +          char *dot_ip = inet_ntoa(addr);
>> +
>> +          msg (M_INFO, "Updating NAT table from localhost to: %s",
>> dot_ip); +          ret = true;
>> +        }
>> +    }
>> +
>> +  return ret;
>> +}
>> +
>>  #endif
>> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
>> old mode 100644
>> new mode 100755
>> index d55a727..ce995d9
>> --- a/src/openvpn/clinat.h
>> +++ b/src/openvpn/clinat.h
>> @@ -62,4 +62,6 @@ void client_nat_transform (const struct
>> client_nat_option_list *list,
>>     struct buffer *ipbuf,
>>     const int direction);
>>  +bool update_localhost_nat(struct client_nat_option_list *dest,
>> in_addr_t local_ip);
>> +
>>  #endif
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> old mode 100644
>> new mode 100755
>> index 71c91a2..4a63ee8
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -1476,6 +1476,10 @@ do_open_tun (struct context *c)
>>         c->c1.tuntap->post_open_mtu,
>>         SET_MTU_TUN | SET_MTU_UPPER_BOUND);
>>  +#ifdef ENABLE_CLIENT_NAT
>> +      update_localhost_nat(c->options.client_nat, c->c1.tuntap->local);
>> +#endif
>> +
>>        ret = true;
>>        static_context = c;
>>      }
>> --
>> 1.7.9.5
>>
>>
>> From 18b1411689df67feafeb15630c3519ab2cbd42d4 Mon Sep 17 00:00:00 2001
>> From: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> Date: Fri, 14 Aug 2015 15:27:50 -0300
>> Subject: [PATCH] Added FTP NAT support. This feature can be enabled via
>>  --enable-nat-ftp-support option.
>>
>>
>> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>>
>> ---
>>  src/openvpn/clinat.c  |  773
>> ++++++++++++++++++++++++++++++++++++++++++++++---
>>  src/openvpn/clinat.h  |   15 +-
>>  src/openvpn/forward.c |   75 ++---
>>  src/openvpn/options.c |   12 +
>>  src/openvpn/options.h |    1 +
>>  5 files changed, 787 insertions(+), 89 deletions(-)
>>  mode change 100644 => 100755 src/openvpn/forward.c
>>  mode change 100644 => 100755 src/openvpn/options.c
>>  mode change 100644 => 100755 src/openvpn/options.h
>>
>> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
>> index 2460185..1d213f5 100755
>> --- a/src/openvpn/clinat.c
>> +++ b/src/openvpn/clinat.c
>> @@ -36,6 +36,159 @@
>>  #include "proto.h"
>>  #include "socket.h"
>>  #include "memdbg.h"
>> +#include <stdio.h>
>> +#include <ctype.h>
>> +#include <string.h>
>> +
>> +/* Delta Table Types */
>> +
>> +typedef struct delta_table_key {
>> +  uint32_t src_addr;
>> +  uint32_t dest_addr;
>> +  uint16_t src_port;
>> +  uint16_t dest_port;
>> +} delta_table_key_t;
>> +
>> +typedef struct delta_table_entry {
>> +  delta_table_key_t key;
>> +  uint16_t delta_out;
>> +  uint16_t delta_in;
>> +  uint8_t marked_to_remove;
>> +  uint8_t reserved[3];
>> +  uint32_t timestamp;
>> +  struct delta_table_entry *_next;
>> +} delta_table_entry_t;
>> +
>> +typedef struct delta_table {
>> +    struct delta_table_entry *head;
>> +} delta_table_t;
>> +
>> +
>> +// Global delta table
>> +//#define DEBUG_DELTA 1
>> +
>> +delta_table_t *table = NULL;
>> +
>> +#define TIME_TO_RESPOND 60 * 5 // 5 Minutes
>> +#define TIME_TO_LIVE 24 * 60 * 60
>> +
>> +/* Delta Table Functions */
>> +
>> +// In seconds, since epoch
>> +static uint32_t +get_timestamp() {
>> +  return (uint32_t)time(NULL);
>> +}
>> +
>> +static void +print_delta_table_entries(delta_table_t *table) {
>> +    delta_table_entry_t *current = table->head;
>> +
>> +  if (current == NULL) {
>> +    return;
>> +  }
>> +
>> +  while (current != NULL) {
>> +    printf("from %d -> to %d: removed: %s, timestamp: %d, delta_out: %d,
>> delta_in: %d\n", +      current->key.src_addr, current->key.dest_addr,
>> current->marked_to_remove ? "true" : "false", +      current->timestamp,
>> current->delta_out, current->delta_in);
>> +    current = current->_next;
>> +  }
>> +}
>> +
>> +static struct delta_table *
>> +init_delta_table() {
>> +  delta_table_t *table = malloc(sizeof(delta_table_t));
>> +  table->head = NULL;
>> +  return table;
>> +}
>> +
>> +static struct delta_table_entry *
>> +add_delta_entry(delta_table_t *table, delta_table_entry_t
>> *new_delta_entry) {
>> +  if (table->head == NULL) {
>> +    table->head = new_delta_entry;
>> +    table->head->_next = NULL;
>> +  } else {
>> +    // Add element to HEAD, for performance gain
>> +    new_delta_entry->_next = table->head;
>> +    table->head = new_delta_entry; +  }
>> +  return new_delta_entry;
>> +}
>> +
>> +static int +remove_delta_entry(delta_table_t *table, delta_table_entry_t
>> *delta_entry) {
>> +  delta_table_entry_t *current = table->head;
>> +  delta_table_entry_t *before = NULL;
>> +  uint8_t found = 0;
>> +
>> +  //msg (M_INFO, "On remove_delta_entry - entry: %p", &delta_entry);
>> +
>> +  while (current != NULL) {
>> +    if(current == delta_entry) {
>> +      found = 1;
>> +      break;
>> +    }
>> +    before = current;
>> +    current = current->_next;
>> +  }
>> +
>> +  //Element not found
>> +  if (!found) {
>> +    return 0;
>> +  }
>> +
>> +  if(before==NULL){
>> +    table->head = table->head->_next;
>> +  } else {
>> +    before->_next = delta_entry->_next;
>> +  }
>> +
>> +  //msg (M_INFO, "On remove_delta_entry - entry: %p - freed",
>> &delta_entry);
>> +  +  free(delta_entry);
>> +  return 1;
>> +}
>> +
>> +static struct delta_table_entry *
>> +get_delta_entry(delta_table_t *table, delta_table_key_t key) {
>> +  delta_table_entry_t *current = table->head;
>> +  delta_table_entry_t *aux = NULL;
>> +  delta_table_entry_t *el = NULL;
>> +
>> +  while (current != NULL) {
>> +    // Check TTL and Timeout
>> +    if ((current->marked_to_remove && get_timestamp() -
>> current->timestamp >= TIME_TO_RESPOND) /* ||  get_timestamp() -
>> current->timestamp >= TIME_TO_LIVE */){
>> +      aux = current;
>> +      //If the CURRENT is to be removed, then dont return it
>> +      if (aux == el) { +        el = NULL;
>> +      }
>> +      current = current->_next;
>> +      remove_delta_entry(table, aux);
>> +    } else {
>> +      if ((
>> +        // Regular connection
>> +        (current->key.src_addr == key.src_addr &&
>> +         current->key.src_port == key.src_port && +
>>  current->key.dest_addr == key.dest_addr && +
>>  current->key.dest_port == key.dest_port) ||
>> +        //Check if it is a returned connection
>> +        (current->key.dest_addr == key.src_addr &&
>> +         current->key.dest_port == key.src_port && +
>>  current->key.src_addr == key.dest_addr && +         current->key.src_port
>> == key.dest_port))) {
>> +        el = current;
>> +      } +      current = current->_next;
>> +    }
>> +  }
>> +
>> +  return el;
>> +}
>> +
>> +/* Delta Table Functions End */
>> +
>>   static bool
>>  add_entry(struct client_nat_option_list *dest,
>> @@ -192,19 +345,533 @@ print_pkt (struct openvpn_iphdr *iph, const char
>> *prefix, const int direction, c
>>    gc_free (&gc);
>>  }
>>  +#if DEBUG_DELTA
>> +
>> +#ifndef HEXDUMP_COLS
>> +#define HEXDUMP_COLS 8
>> +#endif
>> +
>> +static void hexdump(void *mem, unsigned int len)
>> +{
>> +  unsigned int i, j;
>> +        +  for(i = 0; i < len + ((len % HEXDUMP_COLS) ? (HEXDUMP_COLS -
>> len % HEXDUMP_COLS) : 0); i++)
>> +  {
>> +    /* print offset */
>> +    if(i % HEXDUMP_COLS == 0)
>> +    {
>> +      printf("0x%06x: ", i);
>> +    }
>> + +    /* print hex data */
>> +    if(i < len)
>> +    {
>> +      printf("%02x ", 0xFF & ((char*)mem)[i]);
>> +    }
>> +    else /* end of block, just aligning for ASCII dump */
>> +    {
>> +      printf("   ");
>> +    }
>> +                +    /* print ASCII dump */
>> +    if(i % HEXDUMP_COLS == (HEXDUMP_COLS - 1))
>> +    {
>> +      for(j = i - (HEXDUMP_COLS - 1); j <= i; j++)
>> +      {
>> +        unsigned char ch = 0xFF & ((char*)mem)[j];
>> +
>> +        if(j >= len) /* end of block, not really printing */
>> +        {
>> +          putchar(' ');
>> +        } +        else if (ch >= 0x80) +        {
>> +          putchar('.');
>> +        }
>> +        else if(isprint(((char*)mem)[j])) /* printable char */
>> +        {
>> +          putchar(0xFF & ((char*)mem)[j]);        +        }
>> +        else /* other char */
>> +        {
>> +          putchar('.');
>> +        }
>> +      }
>> +      putchar('\n');
>> +    }
>> +  }
>> +}
>> +#endif
>> +
>> +static int try_number(const char *data, size_t dlen, uint32_t array[],
>> +          int array_size, char sep, char term)
>> +{
>> +  uint32_t i, len;
>> +
>> +  memset(array, 0, sizeof(array[0])*array_size);
>> +
>> +  /* Keep data pointing at next char. */
>> +  for (i = 0, len = 0; len < dlen && i < array_size; len++, data++) {
>> +    if (*data >= '0' && *data <= '9') {
>> +      array[i] = array[i]*10 + *data - '0';
>> +    }
>> +    else if (*data == sep)
>> +      i++;
>> +    else {
>> +      /* Unexpected character; true if it's the
>> +         terminator and we're finished. */
>> +      if (*data == term && i == array_size - 1)
>> +        return len;
>> +
>> +      msg (M_ERRNO, "CNAT - try_number - Char %u (got %u nums) `%u'
>> unexpected\n", len, i, *data);
>> +      return 0;
>> +    }
>> +  }
>> +
>> +  msg (M_ERRNO, "CNAT - ERROR: Failed to fill %u numbers separated by
>> %c\n", array_size, sep);
>> +
>> +  return 0;
>> +}
>> +
>> +static int try_rfc959(const char *, size_t, u_int32_t [], char);
>> +
>> +static struct ftp_search {
>> +  int direction;
>> +  const char *pattern;
>> +  size_t plen;
>> +  char skip;
>> +  char term;
>> +  int (*getnum)(const char *, size_t, u_int32_t[], char);
>> +} search[] = {
>> +  {
>> +    CN_OUTGOING,
>> +    "PORT",  sizeof("PORT") - 1, ' ', '\r',
>> +    try_rfc959,
>> +  },
>> +  {
>> +    CN_INCOMING,
>> +    "227 ",  sizeof("227 ") - 1, '(', ')',
>> +    try_rfc959,
>> +  },
>> +};
>> +
>> +
>> +/* Returns 0, or length of numbers: 192,168,1,1,5,6 */
>> +static int +try_rfc959(const char *data, size_t dlen, u_int32_t array[6],
>> +           char term)
>> +{
>> +  return try_number(data, dlen, array, 6, ',', term);
>> +}
>> +
>> +/* Grab port: number up to delimiter */
>> +static int +get_port(const char *data, int start, size_t dlen, char
>> delim,
>> +        u_int32_t array[2])
>> +{
>> +  u_int16_t port = 0;
>> +  int i;
>> +
>> +  for (i = start; i < dlen; i++) {
>> +    /* Finished? */
>> +    if (data[i] == delim) {
>> +      if (port == 0)
>> +        break;
>> +      array[0] = port >> 8;
>> +      array[1] = port;
>> +      return i + 1;
>> +    }
>> +    else if (data[i] >= '0' && data[i] <= '9')
>> +      port = port*10 + data[i] - '0';
>> +    else /* Some other crap */
>> +      break;
>> +  }
>> +  return 0;
>> +}
>> +
>> +/* Return 1 for match, 0 for accept, -1 for partial. */
>> +static int +find_pattern(const char *data, size_t dlen,
>> +      const char *pattern, size_t plen,
>> +      char skip, char term,
>> +      unsigned int *numoff,
>> +      unsigned int *numlen,
>> +      u_int32_t array[6],
>> +      int (*getnum)(const char *, size_t, u_int32_t[], char))
>> +{
>> +  size_t i;
>> +
>> +  if (check_debug_level (D_CLIENT_NAT))
>> +    msg (M_INFO, "CNAT - find_pattern %s: dlen = %u\n", pattern, dlen);
>> +
>> +  if (dlen == 0)
>> +    return 0;
>> +
>> +  if (dlen <= plen) {
>> +    /* Short packet: try for partial? */
>> +    if (strncasecmp(data, pattern, dlen) == 0)
>> +      return -1;
>> +    else return 0;
>> +  }
>> +
>> +  if (strncasecmp(data, pattern, plen) != 0) {
>> +    return 0;
>> +  }
>> +
>> +  if (check_debug_level (D_CLIENT_NAT))
>> +    msg (M_INFO, "CNAT - Pattern matches!\n");
>> +
>> +  /* Now we've found the constant string, try to skip
>> +     to the 'skip' character */
>> +  for (i = plen; data[i] != skip; i++)
>> +    if (i == dlen - 1) return -1;
>> +
>> +  /* Skip over the last character */
>> +  i++;
>> +
>> +  if (check_debug_level (D_CLIENT_NAT))
>> +    msg (M_INFO, "CNAT - Skipped up to `%c'!\n", skip);
>> +
>> +  *numoff = i;
>> +  *numlen = getnum(data + i, dlen - i, array, term);
>> +  if (!*numlen)
>> +    return -1;
>> +
>> +  if (check_debug_level (D_CLIENT_NAT))
>> +    msg (M_INFO, "CNAT - Match succeeded!\n");
>> +  +  return 1;
>> +}
>> +
>> +static uint16_t
>> +tcp_checksum (const uint8_t *buf,
>> +        const int len_tcp,
>> +        const uint32_t src_addr,
>> +        const uint32_t dest_addr)
>> +{
>> +  uint16_t word16;
>> +  uint32_t sum = 0;
>> +  int i;
>> +  uint8_t * psrc_addr = (uint8_t *) &src_addr;
>> +  uint8_t * pdest_addr = (uint8_t *) &dest_addr;
>> +  +  /* make 16 bit words out of every two adjacent 8 bit words and  */
>> +  /* calculate the sum of all 16 bit words */
>> +  for (i = 0; i < len_tcp; i += 2){
>> +    word16 = ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_tcp) ? (buf[i+1] &
>> 0xFF) : 0);
>> +    sum += word16;
>> +  }
>> +
>> +  /* add the TCP pseudo header which contains the IP source and
>> destination addresses */
>> +  for (i = 0; i < 4; i += 2){
>> +    word16 =((psrc_addr[i] << 8) & 0xFF00) + (psrc_addr[i+1] & 0xFF);
>> +    sum += word16;
>> +  }
>> +  for (i = 0; i < 4; i += 2){
>> +    word16 =((pdest_addr[i] << 8) & 0xFF00) + (pdest_addr[i+1] & 0xFF);
>> +    sum += word16;   +  }
>> +
>> +  /* the protocol number and the length of the TCP packet */
>> +  sum += (uint16_t) OPENVPN_IPPROTO_TCP + (uint16_t) len_tcp;
>> +
>> +  /* keep only the last 16 bits of the 32 bit calculated sum and add the
>> carries */
>> +  while (sum >> 16)
>> +    sum = (sum & 0xFFFF) + (sum >> 16);
>> +    +  /* Take the one's complement of sum */
>> +  return ((uint16_t) ~sum);
>> +}
>> +
>> +static uint16_t +ip_checksum(const void *buf, uint16_t hdr_len) {
>> +  unsigned long sum = 0;
>> +  const uint16_t *ip1;
>> +
>> +  ip1 = buf;
>> +  while (hdr_len > 1) {
>> +    sum += *ip1++;
>> +    if (sum & 0x80000000)
>> +      sum = (sum & 0xFFFF) + (sum >> 16);
>> +    hdr_len -= 2;
>> +  }
>> +
>> +  while (sum >> 16)
>> +    sum = (sum & 0xFFFF) + (sum >> 16);
>> +
>> +  return(~sum);
>> +}
>> +
>> +static int +client_nat_ftp_transform(struct buffer *ipbuf,
>> +          const int direction, const uint32_t from_address, uint32_t
>> replace_address) {
>> +
>> +  uint32_t array[6] = {0};
>> +  int ret = 0;
>> +  int data_len = 0;
>> +
>> +  struct ip_tcp_udp_hdr *hdr = (struct ip_tcp_udp_hdr *) BPTR (ipbuf);
>> +
>> +  if (hdr->ip.protocol != OPENVPN_IPPROTO_TCP)
>> +    return ret;
>> +
>> +  if (table == NULL) +      table = init_delta_table();
>> +  +  delta_table_entry_t *entry = NULL;
>> +  delta_table_key_t delta_key;
>> +
>> +  // Because the address already was NATed, probably on OpenVPN Server
>> +  if (direction == CN_OUTGOING)
>> +    delta_key.src_addr = from_address;
>> +  else if (direction == CN_INCOMING)
>> +    delta_key.src_addr = hdr->ip.saddr;
>> +
>> +  delta_key.src_port = hdr->u.tcp.source;
>> +  delta_key.dest_addr = hdr->ip.daddr;
>> +  delta_key.dest_port = hdr->u.tcp.dest;
>> +
>> +#if DEBUG_DELTA
>> +  msg (M_INFO, "delta_key - saddr: %d, sport: %d, daddr: %d, dport: %d",
>> +  delta_key.src_addr, delta_key.src_port, delta_key.dest_addr,
>> delta_key.dest_port);
>> +
>> +  msg (M_INFO, "seq: %x, ack: %x", +  hdr->u.tcp.seq,
>> hdr->u.tcp.ack_seq);
>> +#endif
>> +
>> +  int tcp_data_offset = OPENVPN_TCPH_GET_DOFF (hdr->u.tcp.doff_res);
>> +
>> +  struct buffer tcpbuf = *ipbuf;
>> +  if (!buf_advance (&tcpbuf, sizeof(struct openvpn_iphdr) +
>> tcp_data_offset))
>> +    return ret;
>> +
>> +  uint8_t * tcp_data = (uint8_t *) BPTR (&tcpbuf);
>> +
>> +#if DEBUG_DELTA
>> +  msg (M_INFO, "TCP DATA BEFORE NAT:");
>> +  hexdump(tcp_data, BLEN(&tcpbuf));    +#endif
>> +
>> +  u_int32_t matchlen, matchoff;
>> +  int found_pattern = -1;
>> +  int i = 0;
>> +
>> +  for (i = 0; i < sizeof(search) / sizeof(search[0]); i++) {
>> +    if (search[i].direction != direction) continue;
>> +
>> +    found_pattern = find_pattern(tcp_data, BLEN(&tcpbuf),
>> +             search[i].pattern,
>> +             search[i].plen,
>> +             search[i].skip,
>> +             search[i].term,
>> +             &matchoff, &matchlen,
>> +             array,
>> +             search[i].getnum);
>> +    if (found_pattern) break;
>> +  }
>> +
>> +  if (found_pattern > 0) +    {
>> +
>> +      if (check_debug_level (D_CLIENT_NAT)) +        {
>> +          msg (M_INFO, "client-nat FTP match: %.*s - data: %.*s\n",
>> +            matchoff, tcp_data, matchlen, &tcp_data[matchoff]);
>> +        }
>> +
>> +      data_len = BLEN(&tcpbuf) - matchoff;
>> +
>> +      uint32_t ip = htonl((array[0] << 24) | (array[1] << 16)
>> +        | (array[2] << 8) | array[3]);
>> +      uint16_t port = htons(array[4] << 8 | array[5]);
>> +      uint8_t * addr_tmp = (uint8_t *) &replace_address;
>> +
>> +      uint8_t new_tcp_data[32];
>> +      memset(&new_tcp_data[0], 0, sizeof(new_tcp_data));
>> +
>> +      int new_len = sprintf((char *) &new_tcp_data[0],
>> "%d,%d,%d,%d,%d,%d%.*s",
>> +        addr_tmp[0], addr_tmp[1], addr_tmp[2], addr_tmp[3], array[4],
>> array[5], +        data_len - matchlen, (char *)&tcp_data[matchoff +
>> matchlen]);
>> +
>> +      if (check_debug_level (D_CLIENT_NAT)) +        {
>> +          msg (M_INFO, "client-nat replaced address from: %.*s to:
>> %.*s\n",
>> +            data_len, &tcp_data[matchoff], new_len, &new_tcp_data[0]);
>> +        }
>> +
>> +      //If the new len is greater than the old, there will be there an
>> adjustment
>> +      if (new_len > data_len) +        {
>> +          //If the entry already exists
>> +          if (entry = get_delta_entry(table, delta_key)) +            {
>> +              if (direction == CN_OUTGOING) +                {
>> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
>> (entry->delta_out));       // Need to update seq and ack
>> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
>> entry->delta_in);
>> +                  entry->delta_out += new_len - data_len;
>> +                }
>> +              else
>> +                {
>> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
>> (entry->delta_in));        // Need to update seq and ack
>> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
>> entry->delta_out);
>> +                  entry->delta_in += new_len - data_len;
>> +                }
>> +              //Update timestamp entry on delta entry, to keep this
>> delta alive
>> +              entry->timestamp = get_timestamp();
>> +            }
>> +          else +            {
>> +              // No entry found. Add a new one.
>> +              entry = malloc(sizeof(delta_table_entry_t));
>> +              entry->key = delta_key;
>> +
>> +              if (direction == CN_OUTGOING) +                {
>> +                  entry->delta_out = new_len - data_len;
>> +                  entry->delta_in = 0;
>> +                }
>> +              else
>> +                {
>> +                  entry->delta_in = new_len - data_len;
>> +                  entry->delta_out = 0;
>> +                }
>> +              entry->marked_to_remove = 0;
>> +              entry->timestamp = get_timestamp();
>> +        +              //Add it to delta table
>> +              add_delta_entry(table, entry);
>> +            }
>> +
>> +#if DEBUG_DELTA
>> +          print_delta_table_entries(table);
>> +#endif
>> +
>> +          //Increase the tcpbuf and ipbuf reflecting the delta chars
>> added to the segment.
>> +          ASSERT(buf_inc_len(&tcpbuf, new_len - data_len));
>> +          ASSERT(buf_inc_len(ipbuf, new_len - data_len));
>> +
>> +          //Update tot_len
>> +          hdr->ip.tot_len = htons(ntohs(hdr->ip.tot_len) + (new_len -
>> data_len));
>> +
>> +          // Readjust IP Checksum
>> +          uint16_t head_len = OPENVPN_IPH_GET_LEN(hdr->ip.version_len);
>> +          hdr->ip.check = 0;
>> +          uint16_t check = ip_checksum( BPTR (ipbuf), head_len);
>> +          hdr->ip.check = check;
>> +
>> +          //Use new_len here!
>> +          memcpy(&tcp_data[matchoff], new_tcp_data, new_len); +        }
>> +      else
>> +        {
>> +          // The replace size is the lesser or iqual the original? Pad
>> with 0 if necessary.
>> +          memcpy(&tcp_data[matchoff], new_tcp_data, data_len); +
>> +          //If the entry already exists
>> +          if (entry = get_delta_entry(table, delta_key)) +            {
>> +              if (direction == CN_OUTGOING) +                {
>> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
>> (entry->delta_out));       // Need to update seq and ack
>> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
>> entry->delta_in);
>> +                }
>> +              else
>> +                {
>> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
>> (entry->delta_in));        // Need to update seq and ack
>> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
>> entry->delta_out);
>> +                }
>> +              //Update timestamp entry on delta entry, to keep this
>> delta alive
>> +              entry->timestamp = get_timestamp();
>> +            }
>> +
>> +        }
>> +
>> +      //Update TCP checksum
>> +      hdr->u.tcp.check = 0;
>> +
>> +      uint16_t tot_len = ntohs(hdr->ip.tot_len);
>> +      uint16_t head_len = OPENVPN_IPH_GET_LEN(hdr->ip.version_len);
>> +
>> +      uint16_t check = tcp_checksum(BPTR (ipbuf) + head_len, +
>> tot_len - head_len, hdr->ip.saddr, hdr->ip.daddr); +
>> +      hdr->u.tcp.check = htons(check);
>> +      ret = 1;
>> +    }
>> +  else +    {
>> +      //No pattern found. Check if there is a delta entry for this
>> connection
>> +      if(entry = get_delta_entry(table, delta_key)) +        {
>> +          if (direction == CN_OUTGOING) +            {
>> +              hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
>> entry->delta_out);
>> +              hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
>> entry->delta_in);
>> +            } +          else +            {
>> +              hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
>> entry->delta_in);
>> +              hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
>> entry->delta_out);
>> +            }
>> +
>> +          //Update TCP checksum
>> +          hdr->u.tcp.check = 0;
>> +
>> +          uint16_t tot_len = ntohs(hdr->ip.tot_len);
>> +          uint16_t head_len = OPENVPN_IPH_GET_LEN(hdr->ip.version_len);
>> +
>> +          uint16_t check = tcp_checksum(BPTR (ipbuf) + head_len, +
>>     tot_len - head_len, hdr->ip.saddr, hdr->ip.daddr); +
>> +          hdr->u.tcp.check = htons(check);
>> +
>> +          //Update timestamp entry on delta entry
>> +          entry->timestamp = get_timestamp();
>> +
>> +          // If it is a FIN package, then remove entry from delta table
>> +          if (OPENVPN_TCPH_FIN_MASK & hdr->u.tcp.flags) +            {
>> +              entry->marked_to_remove = 1;
>> +              msg (M_INFO, "Delta marked to be removed!");
>> +            }
>> +  +          ret = 1; +        }
>> +      else +        {
>> +#if DEBUG_DELTA
>> +          // Regular package!
>> +          msg (M_INFO, "Regular package!: tot_len %d, seq %x, ack %x\n",
>> ntohs(hdr->ip.tot_len), ntohl(hdr->u.tcp.seq), ntohl(hdr->u.tcp.ack_seq));
>> +#endif
>> +        }
>> +    }
>> +
>> +#if DEBUG_DELTA
>> +  msg (M_INFO, "TCP DATA AFTER NAT:");
>> +  hexdump(tcp_data, BLEN(&tcpbuf));
>> +#endif
>> +
>> +  return ret;
>> +}
>> +
>>  void
>>  client_nat_transform (const struct client_nat_option_list *list,
>> -      struct buffer *ipbuf,
>> -      const int direction)
>> +          struct buffer *ipbuf,
>> +          const int direction, +          const bool
>> enable_nat_ftp_support)
>>  {
>>    struct ip_tcp_udp_hdr *h = (struct ip_tcp_udp_hdr *) BPTR (ipbuf);
>>    int i;
>> -  uint32_t addr, *addr_ptr;
>> +  uint32_t addr, *addr_ptr, from_addr;
>>    const uint32_t *from, *to;
>>    int accumulate = 0;
>>    unsigned int amask;
>>    unsigned int alog = 0;
>>  +  uint32_t orig_saddr = h->ip.saddr;
>> +  uint32_t orig_daddr = h->ip.daddr;
>> +
>>    if (check_debug_level (D_CLIENT_NAT))
>>      print_pkt (&h->ip, "BEFORE", direction, D_CLIENT_NAT);
>>  @@ -212,65 +879,81 @@ client_nat_transform (const struct
>> client_nat_option_list *list,
>>      {
>>        const struct client_nat_entry *e = &list->entries[i]; /* current
>> NAT rule */
>>        if (e->type ^ direction)
>> - {
>> -  addr = *(addr_ptr = &h->ip.daddr);
>> -  amask = 2;
>> - }
>> +        {
>> +          addr = *(addr_ptr = &h->ip.daddr);
>> +          amask = 2;
>> +        }
>>        else
>> - {
>> -  addr = *(addr_ptr = &h->ip.saddr);
>> -  amask = 1;
>> - }
>> +        {
>> +          addr = *(addr_ptr = &h->ip.saddr);
>> +          amask = 1;
>> +        }
>>        if (direction)
>> - {
>> -  from = &e->foreign_network;
>> -  to = &e->network;
>> - }
>> +        {
>> +          from = &e->foreign_network;
>> +          to = &e->network;
>> +        }
>>        else
>> - {
>> -  from = &e->network;
>> -  to = &e->foreign_network;
>> - }
>> +        {
>> +          from = &e->network;
>> +          to = &e->foreign_network;
>> +        }
>>         if (((addr & e->netmask) == *from) && !(amask & alog))
>> - {
>> -  /* pre-adjust IP checksum */
>> -  ADD_CHECKSUM_32(accumulate, addr);
>> +        {
>> +          from_addr = *from;
>> +    +          /* pre-adjust IP checksum */
>> +          ADD_CHECKSUM_32(accumulate, addr);
>>  -  /* do NAT transform */
>> -  addr = (addr & ~e->netmask) | *to;
>> +          /* do NAT transform */
>> +          addr = (addr & ~e->netmask) | *to;
>>  -  /* post-adjust IP checksum */
>> -  SUB_CHECKSUM_32(accumulate, addr);
>> +          /* post-adjust IP checksum */
>> +          SUB_CHECKSUM_32(accumulate, addr);
>>  -  /* write the modified address to packet */
>> -  *addr_ptr = addr;
>> +          /* write the modified address to packet */
>> +          *addr_ptr = addr;
>>  -  /* mark as modified */
>> -  alog |= amask;
>> - }
>> +          /* mark as modified */
>> +          alog |= amask;
>> +        }
>>      }
>>    if (alog)
>>      {
>>        if (check_debug_level (D_CLIENT_NAT))
>> - print_pkt (&h->ip, "AFTER", direction, D_CLIENT_NAT);
>> +        print_pkt (&h->ip, "AFTER", direction, D_CLIENT_NAT);
>>         ADJUST_CHECKSUM(accumulate, h->ip.check);
>>         if (h->ip.protocol == OPENVPN_IPPROTO_TCP)
>> - {
>> -  if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
>> openvpn_tcphdr))
>> -    {
>> -      ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
>> -    }
>> - }
>> +        {
>> +          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) +
>> sizeof(struct openvpn_tcphdr))
>> +            {
>> +              ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
>> +            }
>> +
>> +          uint32_t repl_addr = addr;
>> +      +          if (amask == 2) +            {
>> +              if (direction)
>> +                repl_addr = orig_saddr;
>> +              else
>> +                repl_addr = orig_daddr;
>> +            }
>> +      +          if (enable_nat_ftp_support)
>> +            client_nat_ftp_transform(ipbuf, direction, from_addr,
>> repl_addr);
>> +    +        }
>>        else if (h->ip.protocol == OPENVPN_IPPROTO_UDP)
>> - {
>> -  if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
>> openvpn_udphdr))
>> -    {
>> -      ADJUST_CHECKSUM(accumulate, h->u.udp.check);
>> -    }
>> - }
>> +        {
>> +          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) +
>> sizeof(struct openvpn_udphdr))
>> +           {
>> +              ADJUST_CHECKSUM(accumulate, h->u.udp.check);
>> +            }
>> +        }
>>      }
>>  }
>>  @@ -297,7 +980,7 @@ update_localhost_nat(struct client_nat_option_list
>> *dest, in_addr_t local_ip)
>>            addr.s_addr = nat_entry->network;
>>            char *dot_ip = inet_ntoa(addr);
>>  -          msg (M_INFO, "Updating NAT table from localhost to: %s",
>> dot_ip); +          msg (M_INFO, "CNAT - Updating NAT table from localhost
>> to: %s", dot_ip);            ret = true;
>>          }
>>      }
>> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
>> index ce995d9..a58da5d 100755
>> --- a/src/openvpn/clinat.h
>> +++ b/src/openvpn/clinat.h
>> @@ -52,15 +52,16 @@ void copy_client_nat_option_list (struct
>> client_nat_option_list *dest, const str
>>  void print_client_nat_list(const struct client_nat_option_list *list,
>> int msglevel);
>>   void add_client_nat_to_option_list (struct client_nat_option_list *dest,
>> -    const char *type,
>> -    const char *network,
>> -    const char *netmask,
>> -    const char *foreign_network,
>> -    int msglevel);
>> +            const char *type,
>> +            const char *network,
>> +            const char *netmask,
>> +            const char *foreign_network,
>> +            int msglevel);
>>   void client_nat_transform (const struct client_nat_option_list *list,
>> -   struct buffer *ipbuf,
>> -   const int direction);
>> +            struct buffer *ipbuf,
>> +            const int direction,
>> +            const bool enable_nat_ftp_support);
>>   bool update_localhost_nat(struct client_nat_option_list *dest,
>> in_addr_t local_ip);
>>  diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> old mode 100644
>> new mode 100755
>> index 217fbb3..615db7a
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -980,9 +980,6 @@ process_incoming_tun (struct context *c)
>>     perf_push (PERF_PROC_IN_TUN);
>>  -  if (c->c2.buf.len > 0)
>> -    c->c2.tun_read_bytes += c->c2.buf.len;
>> -
>>  #ifdef LOG_RW
>>    if (c->c2.log_rw && c->c2.buf.len > 0)
>>      fprintf (stderr, "r");
>> @@ -999,6 +996,9 @@ process_incoming_tun (struct context *c)
>>         */
>>        process_ip_header (c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT,
>> &c->c2.buf);
>>  +      if (c->c2.buf.len > 0)
>> +        c->c2.tun_read_bytes += c->c2.buf.len;
>> +
>>  #ifdef PACKET_TRUNCATION_CHECK
>>        /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
>>        ipv4_packet_size_verify (BPTR (&c->c2.buf),
>> @@ -1041,43 +1041,44 @@ process_ip_header (struct context *c, unsigned
>> int flags, struct buffer *buf)
>>  #else
>>        if (flags & PIP_MSSFIX)
>>  #endif
>> - {
>> -  struct buffer ipbuf = *buf;
>> -  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
>> -    {
>> -#if PASSTOS_CAPABILITY
>> -      /* extract TOS from IP header */
>> -      if (flags & PIPV4_PASSTOS)
>> - link_socket_extract_tos (c->c2.link_socket, &ipbuf);
>> -#endif
>> -  -      /* possibly alter the TCP MSS */
>> -      if (flags & PIP_MSSFIX)
>> - mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
>> (&c->c2.frame)));
>> +        {
>> +          if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), buf))
>> +            {
>>   #ifdef ENABLE_CLIENT_NAT
>> -      /* possibly do NAT on packet */
>> -      if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
>> - {
>> -  const int direction = (flags & PIPV4_OUTGOING) ? CN_INCOMING :
>> CN_OUTGOING;
>> -  client_nat_transform (c->options.client_nat, &ipbuf, direction);
>> - }
>> +              /* possibly do NAT on packet */
>> +              if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
>> +                {
>> +                  const int direction = (flags & PIPV4_OUTGOING) ?
>> CN_INCOMING : CN_OUTGOING;
>> +                  client_nat_transform(c->options.client_nat, buf,
>> direction, c->options.enable_nat_ftp_support);
>> +                }
>>  #endif
>> -      /* possibly extract a DHCP router message */
>> -      if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
>> - {
>> -  const in_addr_t dhcp_router = dhcp_extract_router_msg (&ipbuf);
>> -  if (dhcp_router)
>> -    route_list_add_vpn_gateway (c->c1.route_list, c->c2.es <http://c2.es>,
>> dhcp_router);
>>
>> - }
>> -    }
>> -  else if (is_ipv6 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
>> -    {
>> -      /* possibly alter the TCP MSS */
>> -      if (flags & PIP_MSSFIX)
>> - mss_fixup_ipv6 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
>> (&c->c2.frame)));
>> -    }
>> - }
>> +
>> +#if PASSTOS_CAPABILITY
>> +              /* extract TOS from IP header */
>> +              if (flags & PIPV4_PASSTOS)
>> +                link_socket_extract_tos (c->c2.link_socket, buf);
>> +#endif
>> +
>> +              /* possibly alter the TCP MSS */
>> +              if (flags & PIP_MSSFIX)
>> +                mss_fixup_ipv4 (buf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
>> (&c->c2.frame)));
>> +
>> +              /* possibly extract a DHCP router message */
>> +              if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
>> +                {
>> +                  const in_addr_t dhcp_router = dhcp_extract_router_msg
>> (buf);
>> +                  if (dhcp_router)
>> +                    route_list_add_vpn_gateway (c->c1.route_list, c->
>> c2.es <http://c2.es>, dhcp_router);
>>
>> +                }
>> +            }
>> +          else if (is_ipv6 (TUNNEL_TYPE (c->c1.tuntap), buf))
>> +            {
>> +              /* possibly alter the TCP MSS */
>> +              if (flags & PIP_MSSFIX)
>> +                mss_fixup_ipv6 (buf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
>> (&c->c2.frame)));
>> +            }
>> +        }
>>      }
>>  }
>>  diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> old mode 100644
>> new mode 100755
>> index 007bd8c..73b615a
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -236,6 +236,7 @@ static const char usage_message[] =
>>    "                  the default gateway.  Useful when pushing private
>> subnets.\n"
>>  #ifdef ENABLE_CLIENT_NAT
>>    "--client-nat snat|dnat network netmask alias : on client add 1-to-1
>> NAT rule.\n"
>> +  "--enable-nat-ftp-support : Enable NAT FTP Support, updating the IP
>> address on FTP PORT commands or PASV responses\n"   #endif
>>  #ifdef ENABLE_PUSH_PEER_INFO
>>    "--push-peer-info : (client only) push client info to server.\n"
>> @@ -789,6 +790,11 @@ init_options (struct options *o, const bool init_gc)
>>    o->max_routes = MAX_ROUTES_DEFAULT;
>>    o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
>>    o->proto_force = -1;
>> +
>> +#ifdef ENABLE_CLIENT_NAT
>> +  o->enable_nat_ftp_support = false;
>> +#endif
>> +   #ifdef ENABLE_OCC
>>    o->occ = true;
>>  #endif
>> @@ -1535,6 +1541,8 @@ show_settings (const struct options *o)
>>  #ifdef ENABLE_CLIENT_NAT
>>    if (o->client_nat)
>>      print_client_nat_list(o->client_nat, D_SHOW_PARMS);
>> +
>> +  SHOW_BOOL(enable_nat_ftp_support);
>>  #endif
>>   #ifdef ENABLE_MANAGEMENT
>> @@ -5287,6 +5295,10 @@ add_option (struct options *options,
>>        cnol_check_alloc (options);
>>        add_client_nat_to_option_list(options->client_nat, p[1], p[2],
>> p[3], p[4], msglevel);
>>      }
>> +  else if (streq (p[0], "enable_nat_ftp_support"))
>> +    {
>> +      options->enable_nat_ftp_support = true;
>> +    }
>>  #endif
>>    else if (streq (p[0], "route") && p[1])
>>      {
>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>> old mode 100644
>> new mode 100755
>> index af9a47f..2b27368
>> --- a/src/openvpn/options.h
>> +++ b/src/openvpn/options.h
>> @@ -347,6 +347,7 @@ struct options
>>    bool allow_pull_fqdn; /* as a client, allow server to push a FQDN for
>> certain parameters */
>>   #ifdef ENABLE_CLIENT_NAT
>> +  bool enable_nat_ftp_support;
>>    struct client_nat_option_list *client_nat;
>>  #endif
>>
>> --
>> 1.7.9.5
>>
>>
>> From 0aa64f57ecf653cd067dbef2b2378bdfc4f9a754 Mon Sep 17 00:00:00 2001
>> From: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> Date: Fri, 14 Aug 2015 16:46:13 -0300
>> Subject: [PATCH] Removed debug messages.
>>
>>
>> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> ---
>>  src/openvpn/clinat.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
>> index 1d213f5..991ea75 100755
>> --- a/src/openvpn/clinat.c
>> +++ b/src/openvpn/clinat.c
>> @@ -833,7 +833,9 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>>            if (OPENVPN_TCPH_FIN_MASK & hdr->u.tcp.flags)              {
>>                entry->marked_to_remove = 1;
>> +#if DEBUG_DELTA                             msg (M_INFO, "Delta marked
>> to be removed!");
>> +#endif
>>              }
>>               ret = 1;
>> --
>> 1.7.9.5
>>
>>
>> From cf7af4e4784c83a64b8c1e12601d33bdc5b14d59 Mon Sep 17 00:00:00 2001
>> From: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> Date: Thu, 20 Aug 2015 08:47:08 -0300
>> Subject: [PATCH] Fixed FTP NAT IP address.
>>
>>
>> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>>
>> ---
>>  src/openvpn/clinat.c |   30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
>> index 991ea75..ef400de 100755
>> --- a/src/openvpn/clinat.c
>> +++ b/src/openvpn/clinat.c
>> @@ -423,7 +423,7 @@ static int try_number(const char *data, size_t dlen,
>> uint32_t array[],
>>        if (*data == term && i == array_size - 1)
>>          return len;
>>  -      msg (M_ERRNO, "CNAT - try_number - Char %u (got %u nums) `%u'
>> unexpected\n", len, i, *data);
>> +      msg (M_ERRNO, "CNAT - try_number - Char %u (got %u nums) '%u'
>> unexpected\n", len, i, *data);
>>        return 0;
>>      }
>>    }
>> @@ -433,7 +433,7 @@ static int try_number(const char *data, size_t dlen,
>> uint32_t array[],
>>    return 0;
>>  }
>>  -static int try_rfc959(const char *, size_t, u_int32_t [], char);
>> +static int try_rfc959(const char *, size_t, uint32_t [], char);
>>   static struct ftp_search {
>>    int direction;
>> @@ -441,7 +441,7 @@ static struct ftp_search {
>>    size_t plen;
>>    char skip;
>>    char term;
>> -  int (*getnum)(const char *, size_t, u_int32_t[], char);
>> +  int (*getnum)(const char *, size_t, uint32_t[], char);
>>  } search[] = {
>>    {
>>      CN_OUTGOING,
>> @@ -458,7 +458,7 @@ static struct ftp_search {
>>   /* Returns 0, or length of numbers: 192,168,1,1,5,6 */
>>  static int -try_rfc959(const char *data, size_t dlen, u_int32_t array[6],
>> +try_rfc959(const char *data, size_t dlen, uint32_t array[6],
>>             char term)
>>  {
>>    return try_number(data, dlen, array, 6, ',', term);
>> @@ -467,9 +467,9 @@ try_rfc959(const char *data, size_t dlen, u_int32_t
>> array[6],
>>  /* Grab port: number up to delimiter */
>>  static int  get_port(const char *data, int start, size_t dlen, char
>> delim,
>> -        u_int32_t array[2])
>> +        uint32_t array[2])
>>  {
>> -  u_int16_t port = 0;
>> +  uint16_t port = 0;
>>    int i;
>>     for (i = start; i < dlen; i++) {
>> @@ -496,13 +496,13 @@ find_pattern(const char *data, size_t dlen,
>>        char skip, char term,
>>        unsigned int *numoff,
>>        unsigned int *numlen,
>> -      u_int32_t array[6],
>> -      int (*getnum)(const char *, size_t, u_int32_t[], char))
>> +      uint32_t array[6],
>> +      int (*getnum)(const char *, size_t, uint32_t[], char))
>>  {
>>    size_t i;
>>     if (check_debug_level (D_CLIENT_NAT))
>> -    msg (M_INFO, "CNAT - find_pattern %s: dlen = %u\n", pattern, dlen);
>> +    msg (M_INFO, "CNAT - find_pattern %s: dlen = %u\n", pattern,
>> (uint32_t) dlen);
>>     if (dlen == 0)
>>      return 0;
>> @@ -530,7 +530,7 @@ find_pattern(const char *data, size_t dlen,
>>    i++;
>>     if (check_debug_level (D_CLIENT_NAT))
>> -    msg (M_INFO, "CNAT - Skipped up to `%c'!\n", skip);
>> +    msg (M_INFO, "CNAT - Skipped up to '%c' (%d)!\n", skip, skip);
>>     *numoff = i;
>>    *numlen = getnum(data + i, dlen - i, array, term);
>> @@ -652,7 +652,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>>    hexdump(tcp_data, BLEN(&tcpbuf));     #endif
>>  -  u_int32_t matchlen, matchoff;
>> +  uint32_t matchlen, matchoff;
>>    int found_pattern = -1;
>>    int i = 0;
>>  @@ -689,7 +689,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>>        uint8_t new_tcp_data[32];
>>        memset(&new_tcp_data[0], 0, sizeof(new_tcp_data));
>>  -      int new_len = sprintf((char *) &new_tcp_data[0],
>> "%d,%d,%d,%d,%d,%d%.*s",
>> +      int new_len = sprintf((char *) &new_tcp_data[0],
>> "%03d,%03d,%03d,%03d,%03d,%03d%.*s",
>>          addr_tmp[0], addr_tmp[1], addr_tmp[2], addr_tmp[3], array[4],
>> array[5],          data_len - matchlen, (char *)&tcp_data[matchoff +
>> matchlen]);
>>  @@ -700,7 +700,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>>          }
>>         //If the new len is greater than the old, there will be there an
>> adjustment
>> -      if (new_len > data_len) +      if (replace_address != ip &&
>> new_len > data_len)          {
>>            //If the entry already exists
>>            if (entry = get_delta_entry(table, delta_key)) @@ -765,8
>> +765,8 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>>          }
>>        else
>>          {
>> -          // The replace size is the lesser or iqual the original? Pad
>> with 0 if necessary.
>> -          memcpy(&tcp_data[matchoff], new_tcp_data, data_len); +
>>   if (replace_address != ip)
>> +            memcpy(&tcp_data[matchoff], new_tcp_data, data_len);
>>      //If the entry already exists
>>            if (entry = get_delta_entry(table, delta_key))
>> --
>> 1.7.9.5
>>
>>
>> From 63b1ddad1628eb1a179c2bf5010b781284d2bc4f Mon Sep 17 00:00:00 2001
>> From: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> Date: Sat, 15 Aug 2015 16:58:45 -0300
>> Subject: [PATCH] Fixed options parameter name enable-nat-ftp-support.
>>
>>
>> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> ---
>>  src/openvpn/options.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 73b615a..1a012e4 100755
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -5295,7 +5295,7 @@ add_option (struct options *options,
>>        cnol_check_alloc (options);
>>        add_client_nat_to_option_list(options->client_nat, p[1], p[2],
>> p[3], p[4], msglevel);
>>      }
>> -  else if (streq (p[0], "enable_nat_ftp_support"))
>> +  else if (streq (p[0], "enable-nat-ftp-support"))
>>      {
>>        options->enable_nat_ftp_support = true;
>>      }
>> --
>> 1.7.9.5
>>
>>
>> From 2f5ac96c0c2c5d9d06a11e0b08ae958e09c2e9b5 Mon Sep 17 00:00:00 2001
>> From: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>> Date: Mon, 24 Aug 2015 09:15:34 -0300
>> Subject: [PATCH] Allows set yes/no option to enable-nat-ftp-support
>> feature.
>>
>>
>> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... <mailto:
>> rafael.oliveira@...2056...>>
>>
>> ---
>>  src/openvpn/options.c |   21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 1a012e4..4d73d87 100755
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -236,7 +236,9 @@ static const char usage_message[] =
>>    "                  the default gateway.  Useful when pushing private
>> subnets.\n"
>>  #ifdef ENABLE_CLIENT_NAT
>>    "--client-nat snat|dnat network netmask alias : on client add 1-to-1
>> NAT rule.\n"
>> -  "--enable-nat-ftp-support : Enable NAT FTP Support, updating the IP
>> address on FTP PORT commands or PASV responses\n"  +
>> "--enable-nat-ftp-support : Enable NAT FTP Support, replacing the IP
>> address on FTP PORT commands or PASV responses?\n"  +  "
>> 'no'    -- No, disable this feature.\n"
>> +  "                  'yes'   -- Yes, enable this feature (Enabled by
>> default on Windows).\n"
>>  #endif
>>  #ifdef ENABLE_PUSH_PEER_INFO
>>    "--push-peer-info : (client only) push client info to server.\n"
>> @@ -792,8 +794,12 @@ init_options (struct options *o, const bool init_gc)
>>    o->proto_force = -1;
>>   #ifdef ENABLE_CLIENT_NAT
>> +#ifdef WIN32
>> +  o->enable_nat_ftp_support = true;
>> +#else
>>    o->enable_nat_ftp_support = false;
>>  #endif
>> +#endif
>>     #ifdef ENABLE_OCC
>>    o->occ = true;
>> @@ -5297,7 +5303,18 @@ add_option (struct options *options,
>>      }
>>    else if (streq (p[0], "enable-nat-ftp-support"))
>>      {
>> -      options->enable_nat_ftp_support = true;
>> +      if (p[1])
>> +        {
>> +          if (streq (p[1], "yes"))
>> +            options->enable_nat_ftp_support = true;
>> +          else if (streq (p[1], "no"))
>> +            options->enable_nat_ftp_support = false;
>> +          else
>> +            {
>> +              msg (msglevel, "bad enable-nat-ftp-support option: %s --
>> must be 'yes' or 'no'", p[1]);
>> +              goto err;
>> +            }
>> +        }
>>      }
>>  #endif
>>    else if (streq (p[0], "route") && p[1])
>> --
>> 1.7.9.5
>>
>>
>> ------------------------------------------------------------------------
>>
>>
>> ------------------------------------------------------------------------------
>>   ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>
>

--001a113fd83af6592b051e38d1ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi JJK,<div><br></div><div>&quot;client-ip&quot; instead o=
f &quot;localhost&quot; sounds good to me.</div><div><br></div><div>BR</div=
><div><br></div><div>Gava<br><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Wed, Aug 26, 2015 at 10:01 AM, Jan Just Keijser <span dir=3D=
"ltr">&lt;<a href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...220...=
..1147...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<span=
 class=3D""><br>
<br>
Rafael Gava wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
this is my first submission to the list and I hope that I&#39;m doing in th=
e right way. :-)<br>
<br>
<br>
Well, the features added to Network Address Translator are:<br>
<br>
1) Allow the user to use the string &quot;localhost&quot; on the client-nat=
 network configuration in a way that is not necessary to inform the IP addr=
ess beforehand. Openvpn will set the dynamic received IP from DHCP. Example=
:<br>
<br>
client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the &#39;l=
ocalhost&#39; string with the DHCP address received from openvpn server.<br>
<br>
</blockquote></span>
I understand the idea behind it but it would be a NACK from me on the strin=
g &quot;localhost&quot; - to me, localhost is 127.0.0.1 or ::1, not the DHC=
P-IP ; perhaps use something like &quot;client-ip&quot;=C2=A0 =C2=A0?<span =
class=3D""><br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
2) Allow the user to enable the FTP NAT support through the --enable-nat-ft=
p-support option. This is useful for systems that don&#39;t have conntrack-=
tools support, for example on Windows systems. On windows this feature is e=
nabled by default.<br>
<br>
enable-nat-ftp-support (yes | no)<br>
<br>
</blockquote></span>
sounds like a useful feature to me.<br>
<br>
<br>
JJK<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">
<br>
The following patch was written based on release/2.3 branch.<br>
---------------------------------------------------------------------------=
-----------------------------------------------------------<br>
<br>
From d11957a025dc6c113874e7b04ce4c8e9513c3b02 Mon Sep 17 00:00:00 2001<br>
From: venturus &lt;venturus@...2055...(none)&gt;<br>
Date: Thu, 13 Aug 2015 08:26:36 -0300<br>
Subject: [PATCH] Replaces the client-nat network string &#39;localhost&#39;=
 with the<br>
=C2=A0dynamic IP set to the tun/tap interface by the openvpn<br>
=C2=A0server. Example:<br>
<br>
--client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the &#39=
;localhost&#39; string with the DHCP address received from openvpn server.<=
br>
<br></span>
Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056...=
" target=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;&gt;<div><div class=3D"h5"><br>
---<br>
=C2=A0src/openvpn/clinat.c |=C2=A0 =C2=A057 +++++++++++++++++++++++++++++++=
+++++++++++--------<br>
=C2=A0src/openvpn/clinat.h |=C2=A0 =C2=A0 2 ++<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0|=C2=A0 =C2=A0 4 ++++<br>
=C2=A03 files changed, 54 insertions(+), 9 deletions(-)<br>
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.c<br>
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/clinat.h<br>
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/init.c<br>
<br>
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>
old mode 100644<br>
new mode 100755<br>
index af75fc9..2460185<br>
--- a/src/openvpn/clinat.c<br>
+++ b/src/openvpn/clinat.c<br>
@@ -107,11 +107,11 @@ copy_client_nat_option_list (struct client_nat_option=
_list *dest,<br>
=C2=A0 void<br>
=C2=A0add_client_nat_to_option_list (struct client_nat_option_list *dest,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 const char *type,<br>
-=C2=A0 =C2=A0 =C2=A0 const char *network,<br>
-=C2=A0 =C2=A0 =C2=A0 const char *netmask,<br>
-=C2=A0 =C2=A0 =C2=A0 const char *foreign_network,<br>
-=C2=A0 =C2=A0 =C2=A0 int msglevel)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *network,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *netmask,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *foreign_network,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int msglevel)<br>
=C2=A0{<br>
=C2=A0 =C2=A0struct client_nat_entry e;<br>
=C2=A0 =C2=A0bool ok;<br>
@@ -126,12 +126,19 @@ add_client_nat_to_option_list (struct client_nat_opti=
on_list *dest,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0-=C2=A0 e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<br>
-=C2=A0 if (!ok)<br>
+=C2=A0 if (network &amp;&amp; !strcmp(network, &quot;localhost&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;client-nat: bad network: %s&quot;=
, network);<br>
-=C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;*** client-nat localhost detected.=
..&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 e.network =3D 0xFFFFFFFF;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 e.network =3D getaddr(0, network, 0, &amp;ok, NULL);<=
br>
+=C2=A0 =C2=A0 =C2=A0 if (!ok)<br>
+=C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;client-nat: bad network: %=
s&quot;, network);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0e.netmask =3D getaddr(0, netmask, 0, &amp;ok, N=
ULL);<br>
=C2=A0 =C2=A0if (!ok)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -148,6 +155,7 @@ add_client_nat_to_option_list (struct client_nat_option=
_list *dest,<br>
=C2=A0 =C2=A0add_entry(dest, &amp;e);<br>
=C2=A0}<br>
=C2=A0+<br>
=C2=A0#if 0<br>
=C2=A0static void<br>
=C2=A0print_checksum (struct openvpn_iphdr *iph, const char *prefix)<br>
@@ -266,4 +274,35 @@ client_nat_transform (const struct client_nat_option_l=
ist *list,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
=C2=A0+/*<br>
+* Replaces the localhost token with the IP received from OpenVPN<br>
+*/<br>
+bool +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t =
local_ip)<br>
+{<br>
+=C2=A0 int i;<br>
+=C2=A0 bool ret =3D false;<br>
+<br>
+=C2=A0 if (!dest)<br>
+=C2=A0 =C2=A0 return ret;<br>
+<br>
+=C2=A0 for (i=3D0; i &lt;=3D dest-&gt;n; i++) +=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 struct client_nat_entry *nat_entry =3D &amp;dest-&gt;=
entries[i];<br>
+=C2=A0 =C2=A0 =C2=A0 if (nat_entry &amp;&amp; nat_entry-&gt;network =3D=3D=
 0xFFFFFFFF) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct in_addr addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nat=
_entry-&gt;network =3D ntohl(local_ip);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr.s_addr =3D nat_entry-&gt;network;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dot_ip =3D inet_ntoa(addr);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;Updating NAT table f=
rom localhost to: %s&quot;, dot_ip); +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
t =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#endif<br>
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h<br>
old mode 100644<br>
new mode 100755<br>
index d55a727..ce995d9<br>
--- a/src/openvpn/clinat.h<br>
+++ b/src/openvpn/clinat.h<br>
@@ -62,4 +62,6 @@ void client_nat_transform (const struct client_nat_option=
_list *list,<br>
=C2=A0 =C2=A0 struct buffer *ipbuf,<br>
=C2=A0 =C2=A0 const int direction);<br>
=C2=A0+bool update_localhost_nat(struct client_nat_option_list *dest, in_ad=
dr_t local_ip);<br>
+<br>
=C2=A0#endif<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
old mode 100644<br>
new mode 100755<br>
index 71c91a2..4a63ee8<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -1476,6 +1476,10 @@ do_open_tun (struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;post_open_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SET_MTU_TUN | SET_MTU_UPPER_BOUND);<br>
=C2=A0+#ifdef ENABLE_CLIENT_NAT<br>
+=C2=A0 =C2=A0 =C2=A0 update_localhost_nat(c-&gt;options.client_nat, c-&gt;=
c1.tuntap-&gt;local);<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0static_context =3D c;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
1.7.9.5<br>
<br>
<br>
From 18b1411689df67feafeb15630c3519ab2cbd42d4 Mon Sep 17 00:00:00 2001<br>=
</div></div>
From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=
=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"mailto:raf=
ael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a>&g=
t;&gt;<span class=3D""><br>
Date: Fri, 14 Aug 2015 15:27:50 -0300<br>
Subject: [PATCH] Added FTP NAT support. This feature can be enabled via<br>
=C2=A0--enable-nat-ftp-support option.<br>
<br>
<br></span>
Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056...=
" target=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;&gt;<div><div class=3D"h5"><br>
---<br>
=C2=A0src/openvpn/clinat.c=C2=A0 |=C2=A0 773 ++++++++++++++++++++++++++++++=
++++++++++++++++---<br>
=C2=A0src/openvpn/clinat.h=C2=A0 |=C2=A0 =C2=A015 +-<br>
=C2=A0src/openvpn/forward.c |=C2=A0 =C2=A075 ++---<br>
=C2=A0src/openvpn/options.c |=C2=A0 =C2=A012 +<br>
=C2=A0src/openvpn/options.h |=C2=A0 =C2=A0 1 +<br>
=C2=A05 files changed, 787 insertions(+), 89 deletions(-)<br>
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/forward.c<br>
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/options.c<br>
=C2=A0mode change 100644 =3D&gt; 100755 src/openvpn/options.h<br>
<br>
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>
index 2460185..1d213f5 100755<br>
--- a/src/openvpn/clinat.c<br>
+++ b/src/openvpn/clinat.c<br>
@@ -36,6 +36,159 @@<br>
=C2=A0#include &quot;proto.h&quot;<br>
=C2=A0#include &quot;socket.h&quot;<br>
=C2=A0#include &quot;memdbg.h&quot;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;ctype.h&gt;<br>
+#include &lt;string.h&gt;<br>
+<br>
+/* Delta Table Types */<br>
+<br>
+typedef struct delta_table_key {<br>
+=C2=A0 uint32_t src_addr;<br>
+=C2=A0 uint32_t dest_addr;<br>
+=C2=A0 uint16_t src_port;<br>
+=C2=A0 uint16_t dest_port;<br>
+} delta_table_key_t;<br>
+<br>
+typedef struct delta_table_entry {<br>
+=C2=A0 delta_table_key_t key;<br>
+=C2=A0 uint16_t delta_out;<br>
+=C2=A0 uint16_t delta_in;<br>
+=C2=A0 uint8_t marked_to_remove;<br>
+=C2=A0 uint8_t reserved[3];<br>
+=C2=A0 uint32_t timestamp;<br>
+=C2=A0 struct delta_table_entry *_next;<br>
+} delta_table_entry_t;<br>
+<br>
+typedef struct delta_table {<br>
+=C2=A0 =C2=A0 struct delta_table_entry *head;<br>
+} delta_table_t;<br>
+<br>
+<br>
+// Global delta table<br>
+//#define DEBUG_DELTA 1<br>
+<br>
+delta_table_t *table =3D NULL;<br>
+<br>
+#define TIME_TO_RESPOND 60 * 5 // 5 Minutes<br>
+#define TIME_TO_LIVE 24 * 60 * 60<br>
+<br>
+/* Delta Table Functions */<br>
+<br>
+// In seconds, since epoch<br>
+static uint32_t +get_timestamp() {<br>
+=C2=A0 return (uint32_t)time(NULL);<br>
+}<br>
+<br>
+static void +print_delta_table_entries(delta_table_t *table) {<br>
+=C2=A0 =C2=A0 delta_table_entry_t *current =3D table-&gt;head;<br>
+<br>
+=C2=A0 if (current =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 return;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 while (current !=3D NULL) {<br>
+=C2=A0 =C2=A0 printf(&quot;from %d -&gt; to %d: removed: %s, timestamp: %d=
, delta_out: %d, delta_in: %d\n&quot;, +=C2=A0 =C2=A0 =C2=A0 current-&gt;ke=
y.src_addr, current-&gt;key.dest_addr, current-&gt;marked_to_remove ? &quot=
;true&quot; : &quot;false&quot;, +=C2=A0 =C2=A0 =C2=A0 current-&gt;timestam=
p, current-&gt;delta_out, current-&gt;delta_in);<br>
+=C2=A0 =C2=A0 current =3D current-&gt;_next;<br>
+=C2=A0 }<br>
+}<br>
+<br>
+static struct delta_table *<br>
+init_delta_table() {<br>
+=C2=A0 delta_table_t *table =3D malloc(sizeof(delta_table_t));<br>
+=C2=A0 table-&gt;head =3D NULL;<br>
+=C2=A0 return table;<br>
+}<br>
+<br>
+static struct delta_table_entry *<br>
+add_delta_entry(delta_table_t *table, delta_table_entry_t *new_delta_entry=
) {<br>
+=C2=A0 if (table-&gt;head =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 table-&gt;head =3D new_delta_entry;<br>
+=C2=A0 =C2=A0 table-&gt;head-&gt;_next =3D NULL;<br>
+=C2=A0 } else {<br>
+=C2=A0 =C2=A0 // Add element to HEAD, for performance gain<br>
+=C2=A0 =C2=A0 new_delta_entry-&gt;_next =3D table-&gt;head;<br>
+=C2=A0 =C2=A0 table-&gt;head =3D new_delta_entry; +=C2=A0 }<br>
+=C2=A0 return new_delta_entry;<br>
+}<br>
+<br>
+static int +remove_delta_entry(delta_table_t *table, delta_table_entry_t *=
delta_entry) {<br>
+=C2=A0 delta_table_entry_t *current =3D table-&gt;head;<br>
+=C2=A0 delta_table_entry_t *before =3D NULL;<br>
+=C2=A0 uint8_t found =3D 0;<br>
+<br>
+=C2=A0 //msg (M_INFO, &quot;On remove_delta_entry - entry: %p&quot;, &amp;=
delta_entry);<br>
+<br>
+=C2=A0 while (current !=3D NULL) {<br>
+=C2=A0 =C2=A0 if(current =3D=3D delta_entry) {<br>
+=C2=A0 =C2=A0 =C2=A0 found =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 before =3D current;<br>
+=C2=A0 =C2=A0 current =3D current-&gt;_next;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 //Element not found<br>
+=C2=A0 if (!found) {<br>
+=C2=A0 =C2=A0 return 0;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 if(before=3D=3DNULL){<br>
+=C2=A0 =C2=A0 table-&gt;head =3D table-&gt;head-&gt;_next;<br>
+=C2=A0 } else {<br>
+=C2=A0 =C2=A0 before-&gt;_next =3D delta_entry-&gt;_next;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 //msg (M_INFO, &quot;On remove_delta_entry - entry: %p - freed&quot=
;, &amp;delta_entry);<br>
+=C2=A0 +=C2=A0 free(delta_entry);<br>
+=C2=A0 return 1;<br>
+}<br>
+<br>
+static struct delta_table_entry *<br>
+get_delta_entry(delta_table_t *table, delta_table_key_t key) {<br>
+=C2=A0 delta_table_entry_t *current =3D table-&gt;head;<br>
+=C2=A0 delta_table_entry_t *aux =3D NULL;<br>
+=C2=A0 delta_table_entry_t *el =3D NULL;<br>
+<br>
+=C2=A0 while (current !=3D NULL) {<br>
+=C2=A0 =C2=A0 // Check TTL and Timeout<br>
+=C2=A0 =C2=A0 if ((current-&gt;marked_to_remove &amp;&amp; get_timestamp()=
 - current-&gt;timestamp &gt;=3D TIME_TO_RESPOND) /* ||=C2=A0 get_timestamp=
() - current-&gt;timestamp &gt;=3D TIME_TO_LIVE */){<br>
+=C2=A0 =C2=A0 =C2=A0 aux =3D current;<br>
+=C2=A0 =C2=A0 =C2=A0 //If the CURRENT is to be removed, then dont return i=
t<br>
+=C2=A0 =C2=A0 =C2=A0 if (aux =3D=3D el) { +=C2=A0 =C2=A0 =C2=A0 =C2=A0 el =
=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 current =3D current-&gt;_next;<br>
+=C2=A0 =C2=A0 =C2=A0 remove_delta_entry(table, aux);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 if ((<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Regular connection<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (current-&gt;key.src_addr =3D=3D key.src_addr =
&amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current-&gt;key.src_port =3D=3D key.src_=
port &amp;&amp; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current-&gt;key.dest_add=
r =3D=3D key.dest_addr &amp;&amp; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curren=
t-&gt;key.dest_port =3D=3D key.dest_port) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 //Check if it is a returned connection<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (current-&gt;key.dest_addr =3D=3D key.src_addr=
 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current-&gt;key.dest_port =3D=3D key.src=
_port &amp;&amp; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current-&gt;key.src_add=
r =3D=3D key.dest_addr &amp;&amp; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curren=
t-&gt;key.src_port =3D=3D key.dest_port))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 el =3D current;<br>
+=C2=A0 =C2=A0 =C2=A0 } +=C2=A0 =C2=A0 =C2=A0 current =3D current-&gt;_next=
;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 return el;<br>
+}<br>
+<br>
+/* Delta Table Functions End */<br>
+<br>
=C2=A0 static bool<br>
=C2=A0add_entry(struct client_nat_option_list *dest,<br>
@@ -192,19 +345,533 @@ print_pkt (struct openvpn_iphdr *iph, const char *pr=
efix, const int direction, c<br>
=C2=A0 =C2=A0gc_free (&amp;gc);<br>
=C2=A0}<br>
=C2=A0+#if DEBUG_DELTA<br>
+<br>
+#ifndef HEXDUMP_COLS<br>
+#define HEXDUMP_COLS 8<br>
+#endif<br>
+<br>
+static void hexdump(void *mem, unsigned int len)<br>
+{<br>
+=C2=A0 unsigned int i, j;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 for(i =3D 0; i &lt; len + ((len % HEXD=
UMP_COLS) ? (HEXDUMP_COLS - len % HEXDUMP_COLS) : 0); i++)<br>
+=C2=A0 {<br>
+=C2=A0 =C2=A0 /* print offset */<br>
+=C2=A0 =C2=A0 if(i % HEXDUMP_COLS =3D=3D 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 printf(&quot;0x%06x: &quot;, i);<br>
+=C2=A0 =C2=A0 }<br>
+ +=C2=A0 =C2=A0 /* print hex data */<br>
+=C2=A0 =C2=A0 if(i &lt; len)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 printf(&quot;%02x &quot;, 0xFF &amp; ((char*)mem)[i])=
;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else /* end of block, just aligning for ASCII dump */<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 =C2=A0&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 /* =
print ASCII dump */<br>
+=C2=A0 =C2=A0 if(i % HEXDUMP_COLS =3D=3D (HEXDUMP_COLS - 1))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 for(j =3D i - (HEXDUMP_COLS - 1); j &lt;=3D i; j++)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char ch =3D 0xFF &amp; ((char*)mem)[j=
];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(j &gt;=3D len) /* end of block, not really =
printing */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 putchar(&#39; &#39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (ch &gt=
;=3D 0x80) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 putchar(&#39;.&#39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if(isprint(((char*)mem)[j])) /* printable=
 char */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 putchar(0xFF &amp; ((char*)mem)[j]);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* other char */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 putchar(&#39;.&#39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 putchar(&#39;\n&#39;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 }<br>
+}<br>
+#endif<br>
+<br>
+static int try_number(const char *data, size_t dlen, uint32_t array[],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int array_size, char sep, char term)<br>
+{<br>
+=C2=A0 uint32_t i, len;<br>
+<br>
+=C2=A0 memset(array, 0, sizeof(array[0])*array_size);<br>
+<br>
+=C2=A0 /* Keep data pointing at next char. */<br>
+=C2=A0 for (i =3D 0, len =3D 0; len &lt; dlen &amp;&amp; i &lt; array_size=
; len++, data++) {<br>
+=C2=A0 =C2=A0 if (*data &gt;=3D &#39;0&#39; &amp;&amp; *data &lt;=3D &#39;=
9&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 array[i] =3D array[i]*10 + *data - &#39;0&#39;;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (*data =3D=3D sep)<br>
+=C2=A0 =C2=A0 =C2=A0 i++;<br>
+=C2=A0 =C2=A0 else {<br>
+=C2=A0 =C2=A0 =C2=A0 /* Unexpected character; true if it&#39;s the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0terminator and we&#39;re finished. */<br>
+=C2=A0 =C2=A0 =C2=A0 if (*data =3D=3D term &amp;&amp; i =3D=3D array_size =
- 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 msg (M_ERRNO, &quot;CNAT - try_number - Char %u (got =
%u nums) `%u&#39; unexpected\n&quot;, len, i, *data);<br>
+=C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 msg (M_ERRNO, &quot;CNAT - ERROR: Failed to fill %u numbers separat=
ed by %c\n&quot;, array_size, sep);<br>
+<br>
+=C2=A0 return 0;<br>
+}<br>
+<br>
+static int try_rfc959(const char *, size_t, u_int32_t [], char);<br>
+<br>
+static struct ftp_search {<br>
+=C2=A0 int direction;<br>
+=C2=A0 const char *pattern;<br>
+=C2=A0 size_t plen;<br>
+=C2=A0 char skip;<br>
+=C2=A0 char term;<br>
+=C2=A0 int (*getnum)(const char *, size_t, u_int32_t[], char);<br>
+} search[] =3D {<br>
+=C2=A0 {<br>
+=C2=A0 =C2=A0 CN_OUTGOING,<br>
+=C2=A0 =C2=A0 &quot;PORT&quot;,=C2=A0 sizeof(&quot;PORT&quot;) - 1, &#39; =
&#39;, &#39;\r&#39;,<br>
+=C2=A0 =C2=A0 try_rfc959,<br>
+=C2=A0 },<br>
+=C2=A0 {<br>
+=C2=A0 =C2=A0 CN_INCOMING,<br>
+=C2=A0 =C2=A0 &quot;227 &quot;,=C2=A0 sizeof(&quot;227 &quot;) - 1, &#39;(=
&#39;, &#39;)&#39;,<br>
+=C2=A0 =C2=A0 try_rfc959,<br>
+=C2=A0 },<br>
+};<br>
+<br>
+<br>
+/* Returns 0, or length of numbers: 192,168,1,1,5,6 */<br>
+static int +try_rfc959(const char *data, size_t dlen, u_int32_t array[6],<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char term)<br>
+{<br>
+=C2=A0 return try_number(data, dlen, array, 6, &#39;,&#39;, term);<br>
+}<br>
+<br>
+/* Grab port: number up to delimiter */<br>
+static int +get_port(const char *data, int start, size_t dlen, char delim,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u_int32_t array[2])<br>
+{<br>
+=C2=A0 u_int16_t port =3D 0;<br>
+=C2=A0 int i;<br>
+<br>
+=C2=A0 for (i =3D start; i &lt; dlen; i++) {<br>
+=C2=A0 =C2=A0 /* Finished? */<br>
+=C2=A0 =C2=A0 if (data[i] =3D=3D delim) {<br>
+=C2=A0 =C2=A0 =C2=A0 if (port =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 array[0] =3D port &gt;&gt; 8;<br>
+=C2=A0 =C2=A0 =C2=A0 array[1] =3D port;<br>
+=C2=A0 =C2=A0 =C2=A0 return i + 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (data[i] &gt;=3D &#39;0&#39; &amp;&amp; data[i] &lt;=
=3D &#39;9&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 port =3D port*10 + data[i] - &#39;0&#39;;<br>
+=C2=A0 =C2=A0 else /* Some other crap */<br>
+=C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 }<br>
+=C2=A0 return 0;<br>
+}<br>
+<br>
+/* Return 1 for match, 0 for accept, -1 for partial. */<br>
+static int +find_pattern(const char *data, size_t dlen,<br>
+=C2=A0 =C2=A0 =C2=A0 const char *pattern, size_t plen,<br>
+=C2=A0 =C2=A0 =C2=A0 char skip, char term,<br>
+=C2=A0 =C2=A0 =C2=A0 unsigned int *numoff,<br>
+=C2=A0 =C2=A0 =C2=A0 unsigned int *numlen,<br>
+=C2=A0 =C2=A0 =C2=A0 u_int32_t array[6],<br>
+=C2=A0 =C2=A0 =C2=A0 int (*getnum)(const char *, size_t, u_int32_t[], char=
))<br>
+{<br>
+=C2=A0 size_t i;<br>
+<br>
+=C2=A0 if (check_debug_level (D_CLIENT_NAT))<br>
+=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - find_pattern %s: dlen =3D %u\n&quo=
t;, pattern, dlen);<br>
+<br>
+=C2=A0 if (dlen =3D=3D 0)<br>
+=C2=A0 =C2=A0 return 0;<br>
+<br>
+=C2=A0 if (dlen &lt;=3D plen) {<br>
+=C2=A0 =C2=A0 /* Short packet: try for partial? */<br>
+=C2=A0 =C2=A0 if (strncasecmp(data, pattern, dlen) =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 else return 0;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 if (strncasecmp(data, pattern, plen) !=3D 0) {<br>
+=C2=A0 =C2=A0 return 0;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 if (check_debug_level (D_CLIENT_NAT))<br>
+=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - Pattern matches!\n&quot;);<br>
+<br>
+=C2=A0 /* Now we&#39;ve found the constant string, try to skip<br>
+=C2=A0 =C2=A0 =C2=A0to the &#39;skip&#39; character */<br>
+=C2=A0 for (i =3D plen; data[i] !=3D skip; i++)<br>
+=C2=A0 =C2=A0 if (i =3D=3D dlen - 1) return -1;<br>
+<br>
+=C2=A0 /* Skip over the last character */<br>
+=C2=A0 i++;<br>
+<br>
+=C2=A0 if (check_debug_level (D_CLIENT_NAT))<br>
+=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - Skipped up to `%c&#39;!\n&quot;, s=
kip);<br>
+<br>
+=C2=A0 *numoff =3D i;<br>
+=C2=A0 *numlen =3D getnum(data + i, dlen - i, array, term);<br>
+=C2=A0 if (!*numlen)<br>
+=C2=A0 =C2=A0 return -1;<br>
+<br>
+=C2=A0 if (check_debug_level (D_CLIENT_NAT))<br>
+=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - Match succeeded!\n&quot;);<br>
+=C2=A0 +=C2=A0 return 1;<br>
+}<br>
+<br>
+static uint16_t<br>
+tcp_checksum (const uint8_t *buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int len_tcp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t src_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t dest_addr)<br>
+{<br>
+=C2=A0 uint16_t word16;<br>
+=C2=A0 uint32_t sum =3D 0;<br>
+=C2=A0 int i;<br>
+=C2=A0 uint8_t * psrc_addr =3D (uint8_t *) &amp;src_addr;<br>
+=C2=A0 uint8_t * pdest_addr =3D (uint8_t *) &amp;dest_addr;<br>
+=C2=A0 +=C2=A0 /* make 16 bit words out of every two adjacent 8 bit words =
and=C2=A0 */<br>
+=C2=A0 /* calculate the sum of all 16 bit words */<br>
+=C2=A0 for (i =3D 0; i &lt; len_tcp; i +=3D 2){<br>
+=C2=A0 =C2=A0 word16 =3D ((buf[i] &lt;&lt; 8) &amp; 0xFF00) + ((i + 1 &lt;=
 len_tcp) ? (buf[i+1] &amp; 0xFF) : 0);<br>
+=C2=A0 =C2=A0 sum +=3D word16;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 /* add the TCP pseudo header which contains the IP source and desti=
nation addresses */<br>
+=C2=A0 for (i =3D 0; i &lt; 4; i +=3D 2){<br>
+=C2=A0 =C2=A0 word16 =3D((psrc_addr[i] &lt;&lt; 8) &amp; 0xFF00) + (psrc_a=
ddr[i+1] &amp; 0xFF);<br>
+=C2=A0 =C2=A0 sum +=3D word16;<br>
+=C2=A0 }<br>
+=C2=A0 for (i =3D 0; i &lt; 4; i +=3D 2){<br>
+=C2=A0 =C2=A0 word16 =3D((pdest_addr[i] &lt;&lt; 8) &amp; 0xFF00) + (pdest=
_addr[i+1] &amp; 0xFF);<br>
+=C2=A0 =C2=A0 sum +=3D word16;=C2=A0 =C2=A0+=C2=A0 }<br>
+<br>
+=C2=A0 /* the protocol number and the length of the TCP packet */<br>
+=C2=A0 sum +=3D (uint16_t) OPENVPN_IPPROTO_TCP + (uint16_t) len_tcp;<br>
+<br>
+=C2=A0 /* keep only the last 16 bits of the 32 bit calculated sum and add =
the carries */<br>
+=C2=A0 while (sum &gt;&gt; 16)<br>
+=C2=A0 =C2=A0 sum =3D (sum &amp; 0xFFFF) + (sum &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 +=C2=A0 /* Take the one&#39;s complement of sum */<br>
+=C2=A0 return ((uint16_t) ~sum);<br>
+}<br>
+<br>
+static uint16_t +ip_checksum(const void *buf, uint16_t hdr_len) {<br>
+=C2=A0 unsigned long sum =3D 0;<br>
+=C2=A0 const uint16_t *ip1;<br>
+<br>
+=C2=A0 ip1 =3D buf;<br>
+=C2=A0 while (hdr_len &gt; 1) {<br>
+=C2=A0 =C2=A0 sum +=3D *ip1++;<br>
+=C2=A0 =C2=A0 if (sum &amp; 0x80000000)<br>
+=C2=A0 =C2=A0 =C2=A0 sum =3D (sum &amp; 0xFFFF) + (sum &gt;&gt; 16);<br>
+=C2=A0 =C2=A0 hdr_len -=3D 2;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 while (sum &gt;&gt; 16)<br>
+=C2=A0 =C2=A0 sum =3D (sum &amp; 0xFFFF) + (sum &gt;&gt; 16);<br>
+<br>
+=C2=A0 return(~sum);<br>
+}<br>
+<br>
+static int +client_nat_ftp_transform(struct buffer *ipbuf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int direction, const uint32_t fro=
m_address, uint32_t replace_address) {<br>
+<br>
+=C2=A0 uint32_t array[6] =3D {0};<br>
+=C2=A0 int ret =3D 0;<br>
+=C2=A0 int data_len =3D 0;<br>
+<br>
+=C2=A0 struct ip_tcp_udp_hdr *hdr =3D (struct ip_tcp_udp_hdr *) BPTR (ipbu=
f);<br>
+<br>
+=C2=A0 if (hdr-&gt;ip.protocol !=3D OPENVPN_IPPROTO_TCP)<br>
+=C2=A0 =C2=A0 return ret;<br>
+<br>
+=C2=A0 if (table =3D=3D NULL) +=C2=A0 =C2=A0 =C2=A0 table =3D init_delta_t=
able();<br>
+=C2=A0 +=C2=A0 delta_table_entry_t *entry =3D NULL;<br>
+=C2=A0 delta_table_key_t delta_key;<br>
+<br>
+=C2=A0 // Because the address already was NATed, probably on OpenVPN Serve=
r<br>
+=C2=A0 if (direction =3D=3D CN_OUTGOING)<br>
+=C2=A0 =C2=A0 delta_key.src_addr =3D from_address;<br>
+=C2=A0 else if (direction =3D=3D CN_INCOMING)<br>
+=C2=A0 =C2=A0 delta_key.src_addr =3D hdr-&gt;ip.saddr;<br>
+<br>
+=C2=A0 delta_key.src_port =3D hdr-&gt;u.tcp.source;<br>
+=C2=A0 delta_key.dest_addr =3D hdr-&gt;ip.daddr;<br>
+=C2=A0 delta_key.dest_port =3D hdr-&gt;u.tcp.dest;<br>
+<br>
+#if DEBUG_DELTA<br>
+=C2=A0 msg (M_INFO, &quot;delta_key - saddr: %d, sport: %d, daddr: %d, dpo=
rt: %d&quot;, +=C2=A0 delta_key.src_addr, delta_key.src_port, delta_key.des=
t_addr, delta_key.dest_port);<br>
+<br>
+=C2=A0 msg (M_INFO, &quot;seq: %x, ack: %x&quot;, +=C2=A0 hdr-&gt;u.tcp.se=
q, hdr-&gt;u.tcp.ack_seq);<br>
+#endif<br>
+<br>
+=C2=A0 int tcp_data_offset =3D OPENVPN_TCPH_GET_DOFF (hdr-&gt;u.tcp.doff_r=
es);<br>
+<br>
+=C2=A0 struct buffer tcpbuf =3D *ipbuf;<br>
+=C2=A0 if (!buf_advance (&amp;tcpbuf, sizeof(struct openvpn_iphdr) + tcp_d=
ata_offset))<br>
+=C2=A0 =C2=A0 return ret;<br>
+<br>
+=C2=A0 uint8_t * tcp_data =3D (uint8_t *) BPTR (&amp;tcpbuf);<br>
+<br>
+#if DEBUG_DELTA<br>
+=C2=A0 msg (M_INFO, &quot;TCP DATA BEFORE NAT:&quot;);<br>
+=C2=A0 hexdump(tcp_data, BLEN(&amp;tcpbuf));=C2=A0 =C2=A0 +#endif<br>
+<br>
+=C2=A0 u_int32_t matchlen, matchoff;<br>
+=C2=A0 int found_pattern =3D -1;<br>
+=C2=A0 int i =3D 0;<br>
+<br>
+=C2=A0 for (i =3D 0; i &lt; sizeof(search) / sizeof(search[0]); i++) {<br>
+=C2=A0 =C2=A0 if (search[i].direction !=3D direction) continue;<br>
+<br>
+=C2=A0 =C2=A0 found_pattern =3D find_pattern(tcp_data, BLEN(&amp;tcpbuf),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0search[i].pattern,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0search[i].plen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0search[i].skip,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0search[i].term,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;matchoff, &amp;matchl=
en,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0array,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0search[i].getnum);<br>
+=C2=A0 =C2=A0 if (found_pattern) break;<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 if (found_pattern &gt; 0) +=C2=A0 =C2=A0 {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 if (check_debug_level (D_CLIENT_NAT)) +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;client-nat FTP match=
: %.*s - data: %.*s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matchoff, tcp_data, matchlen, &a=
mp;tcp_data[matchoff]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 data_len =3D BLEN(&amp;tcpbuf) - matchoff;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 uint32_t ip =3D htonl((array[0] &lt;&lt; 24) | (array=
[1] &lt;&lt; 16)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | (array[2] &lt;&lt; 8) | array[3]);<br>
+=C2=A0 =C2=A0 =C2=A0 uint16_t port =3D htons(array[4] &lt;&lt; 8 | array[5=
]);<br>
+=C2=A0 =C2=A0 =C2=A0 uint8_t * addr_tmp =3D (uint8_t *) &amp;replace_addre=
ss;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 uint8_t new_tcp_data[32];<br>
+=C2=A0 =C2=A0 =C2=A0 memset(&amp;new_tcp_data[0], 0, sizeof(new_tcp_data))=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 int new_len =3D sprintf((char *) &amp;new_tcp_data[0]=
, &quot;%d,%d,%d,%d,%d,%d%.*s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr_tmp[0], addr_tmp[1], addr_tmp[2], addr_tm=
p[3], array[4], array[5], +=C2=A0 =C2=A0 =C2=A0 =C2=A0 data_len - matchlen,=
 (char *)&amp;tcp_data[matchoff + matchlen]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 if (check_debug_level (D_CLIENT_NAT)) +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;client-nat replaced =
address from: %.*s to: %.*s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_len, &amp;tcp_data[matchoff=
], new_len, &amp;new_tcp_data[0]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 //If the new len is greater than the old, there will =
be there an adjustment<br>
+=C2=A0 =C2=A0 =C2=A0 if (new_len &gt; data_len) +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //If the entry already exists<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry =3D get_delta_entry(table, de=
lta_key)) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (direction =3D=3D CN_O=
UTGOING) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + (entry-&gt;delta_out));=C2=A0 =
=C2=A0 =C2=A0 =C2=A0// Need to update seq and ack<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_in);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;d=
elta_out +=3D new_len - data_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + (entry-&gt;delta_in));=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 // Need to update seq and ack<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_out);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;d=
elta_in +=3D new_len - data_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Update timestamp entry =
on delta entry, to keep this delta alive<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;timestamp =3D g=
et_timestamp();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // No entry found. Add a =
new one.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D malloc(sizeof(d=
elta_table_entry_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;key =3D delta_k=
ey;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (direction =3D=3D CN_O=
UTGOING) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;d=
elta_out =3D new_len - data_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;d=
elta_in =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;d=
elta_in =3D new_len - data_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;d=
elta_out =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;marked_to_remov=
e =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;timestamp =3D g=
et_timestamp();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 //Add it to delta table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_delta_entry(table, en=
try);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+#if DEBUG_DELTA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_delta_table_entries(table);<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Increase the tcpbuf and ipbuf reflect=
ing the delta chars added to the segment.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(buf_inc_len(&amp;tcpbuf, new_len=
 - data_len));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(buf_inc_len(ipbuf, new_len - dat=
a_len));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Update tot_len<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;ip.tot_len =3D htons(ntohs(hdr-=
&gt;ip.tot_len) + (new_len - data_len));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Readjust IP Checksum<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t head_len =3D OPENVPN_IPH_GET_L=
EN(hdr-&gt;ip.version_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;ip.check =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t check =3D ip_checksum( BPTR (i=
pbuf), head_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;ip.check =3D check;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Use new_len here!<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;tcp_data[matchoff], new_tcp=
_data, new_len); +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // The replace size is the lesser or iq=
ual the original? Pad with 0 if necessary.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;tcp_data[matchoff], new_tcp=
_data, data_len); +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //If the entry already exists<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry =3D get_delta_entry(table, de=
lta_key)) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (direction =3D=3D CN_O=
UTGOING) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + (entry-&gt;delta_out));=C2=A0 =
=C2=A0 =C2=A0 =C2=A0// Need to update seq and ack<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_in);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + (entry-&gt;delta_in));=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 // Need to update seq and ack<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.t=
cp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_out);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Update timestamp entry =
on delta entry, to keep this delta alive<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;timestamp =3D g=
et_timestamp();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 //Update TCP checksum<br>
+=C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.check =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 uint16_t tot_len =3D ntohs(hdr-&gt;ip.tot_len);<br>
+=C2=A0 =C2=A0 =C2=A0 uint16_t head_len =3D OPENVPN_IPH_GET_LEN(hdr-&gt;ip.=
version_len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 uint16_t check =3D tcp_checksum(BPTR (ipbuf) + head_l=
en, +=C2=A0 =C2=A0 =C2=A0 tot_len - head_len, hdr-&gt;ip.saddr, hdr-&gt;ip.=
daddr); +<br>
+=C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.check =3D htons(check);<br>
+=C2=A0 =C2=A0 =C2=A0 ret =3D 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 else +=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 //No pattern found. Check if there is a delta entry f=
or this connection<br>
+=C2=A0 =C2=A0 =C2=A0 if(entry =3D get_delta_entry(table, delta_key)) +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (direction =3D=3D CN_OUTGOING) +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.seq =3D hto=
nl(ntohl(hdr-&gt;u.tcp.seq) + entry-&gt;delta_out);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.ack_seq =3D=
 htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_in);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.seq =3D hto=
nl(ntohl(hdr-&gt;u.tcp.seq) + entry-&gt;delta_in);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.ack_seq =3D=
 htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_out);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Update TCP checksum<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.check =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t tot_len =3D ntohs(hdr-&gt;ip.t=
ot_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t head_len =3D OPENVPN_IPH_GET_L=
EN(hdr-&gt;ip.version_len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t check =3D tcp_checksum(BPTR (i=
pbuf) + head_len, +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tot_len - head_len, h=
dr-&gt;ip.saddr, hdr-&gt;ip.daddr); +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr-&gt;u.tcp.check =3D htons(check);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Update timestamp entry on delta entry=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;timestamp =3D get_timestamp()=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // If it is a FIN package, then remove =
entry from delta table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OPENVPN_TCPH_FIN_MASK &amp; hdr-&gt=
;u.tcp.flags) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry-&gt;marked_to_remov=
e =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;Delta =
marked to be removed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 1; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 else +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+#if DEBUG_DELTA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Regular package!<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;Regular package!: to=
t_len %d, seq %x, ack %x\n&quot;, ntohs(hdr-&gt;ip.tot_len), ntohl(hdr-&gt;=
u.tcp.seq), ntohl(hdr-&gt;u.tcp.ack_seq));<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#if DEBUG_DELTA<br>
+=C2=A0 msg (M_INFO, &quot;TCP DATA AFTER NAT:&quot;);<br>
+=C2=A0 hexdump(tcp_data, BLEN(&amp;tcpbuf));<br>
+#endif<br>
+<br>
+=C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0void<br>
=C2=A0client_nat_transform (const struct client_nat_option_list *list,<br>
-=C2=A0 =C2=A0 =C2=A0 struct buffer *ipbuf,<br>
-=C2=A0 =C2=A0 =C2=A0 const int direction)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer *ipbuf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int direction, +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const bool enable_nat_ftp_support)<br>
=C2=A0{<br>
=C2=A0 =C2=A0struct ip_tcp_udp_hdr *h =3D (struct ip_tcp_udp_hdr *) BPTR (i=
pbuf);<br>
=C2=A0 =C2=A0int i;<br>
-=C2=A0 uint32_t addr, *addr_ptr;<br>
+=C2=A0 uint32_t addr, *addr_ptr, from_addr;<br>
=C2=A0 =C2=A0const uint32_t *from, *to;<br>
=C2=A0 =C2=A0int accumulate =3D 0;<br>
=C2=A0 =C2=A0unsigned int amask;<br>
=C2=A0 =C2=A0unsigned int alog =3D 0;<br>
=C2=A0+=C2=A0 uint32_t orig_saddr =3D h-&gt;ip.saddr;<br>
+=C2=A0 uint32_t orig_daddr =3D h-&gt;ip.daddr;<br>
+<br>
=C2=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT))<br>
=C2=A0 =C2=A0 =C2=A0print_pkt (&amp;h-&gt;ip, &quot;BEFORE&quot;, direction=
, D_CLIENT_NAT);<br>
=C2=A0@@ -212,65 +879,81 @@ client_nat_transform (const struct client_nat_o=
ption_list *list,<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct client_nat_entry *e =3D &amp;list-&=
gt;entries[i]; /* current NAT rule */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (e-&gt;type ^ direction)<br>
- {<br>
-=C2=A0 addr =3D *(addr_ptr =3D &amp;h-&gt;ip.daddr);<br>
-=C2=A0 amask =3D 2;<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D *(addr_ptr =3D &amp;h-&gt;ip.d=
addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amask =3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
- {<br>
-=C2=A0 addr =3D *(addr_ptr =3D &amp;h-&gt;ip.saddr);<br>
-=C2=A0 amask =3D 1;<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D *(addr_ptr =3D &amp;h-&gt;ip.s=
addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amask =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (direction)<br>
- {<br>
-=C2=A0 from =3D &amp;e-&gt;foreign_network;<br>
-=C2=A0 to =3D &amp;e-&gt;network;<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from =3D &amp;e-&gt;foreign_network;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to =3D &amp;e-&gt;network;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
- {<br>
-=C2=A0 from =3D &amp;e-&gt;network;<br>
-=C2=A0 to =3D &amp;e-&gt;foreign_network;<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from =3D &amp;e-&gt;network;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to =3D &amp;e-&gt;foreign_network;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((addr &amp; e-&gt;netmask) =3D=3D *from) &=
amp;&amp; !(amask &amp; alog))<br>
- {<br>
-=C2=A0 /* pre-adjust IP checksum */<br>
-=C2=A0 ADD_CHECKSUM_32(accumulate, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from_addr =3D *from;<br>
+=C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pre-adjust IP checksu=
m */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADD_CHECKSUM_32(accumulate, addr);<br>
=C2=A0-=C2=A0 /* do NAT transform */<br>
-=C2=A0 addr =3D (addr &amp; ~e-&gt;netmask) | *to;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do NAT transform */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (addr &amp; ~e-&gt;netmask) | =
*to;<br>
=C2=A0-=C2=A0 /* post-adjust IP checksum */<br>
-=C2=A0 SUB_CHECKSUM_32(accumulate, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* post-adjust IP checksum */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUB_CHECKSUM_32(accumulate, addr);<br>
=C2=A0-=C2=A0 /* write the modified address to packet */<br>
-=C2=A0 *addr_ptr =3D addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write the modified address to packet=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *addr_ptr =3D addr;<br>
=C2=A0-=C2=A0 /* mark as modified */<br>
-=C2=A0 alog |=3D amask;<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* mark as modified */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alog |=3D amask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0if (alog)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT))<br>
- print_pkt (&amp;h-&gt;ip, &quot;AFTER&quot;, direction, D_CLIENT_NAT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pkt (&amp;h-&gt;ip, &quot;AFTER&quot;, d=
irection, D_CLIENT_NAT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ADJUST_CHECKSUM(accumulate, h-&gt;ip.check);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (h-&gt;ip.protocol =3D=3D OPENVPN_IPPROTO_TC=
P)<br>
- {<br>
-=C2=A0 if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struc=
t openvpn_tcphdr))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 ADJUST_CHECKSUM(accumulate, h-&gt;u.tcp.check);<br>
-=C2=A0 =C2=A0 }<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BLEN(ipbuf) &gt;=3D sizeof(struct o=
penvpn_iphdr) + sizeof(struct openvpn_tcphdr))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADJUST_CHECKSUM(accumulat=
e, h-&gt;u.tcp.check);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t repl_addr =3D addr;<br>
+=C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amask =3D=3D =
2) +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (direction)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repl_addr =3D orig=
_saddr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repl_addr =3D orig=
_daddr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enable_nat_ft=
p_support)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 client_nat_ftp_transform(ipbuf, =
direction, from_addr, repl_addr);<br>
+=C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (h-&gt;ip.protocol =3D=3D OPENVPN_IPPROT=
O_UDP)<br>
- {<br>
-=C2=A0 if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struc=
t openvpn_udphdr))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 ADJUST_CHECKSUM(accumulate, h-&gt;u.udp.check);<br>
-=C2=A0 =C2=A0 }<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BLEN(ipbuf) &gt;=3D sizeof(struct o=
penvpn_iphdr) + sizeof(struct openvpn_udphdr))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADJUST_CHECKSUM(accumulat=
e, h-&gt;u.udp.check);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
=C2=A0@@ -297,7 +980,7 @@ update_localhost_nat(struct client_nat_option_lis=
t *dest, in_addr_t local_ip)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr =3D nat_entry-&gt;netw=
ork;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dot_ip =3D inet_ntoa(addr);<=
br>
=C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, &quot;Updating NAT t=
able from localhost to: %s&quot;, dot_ip); +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 msg (M_INFO, &quot;CNAT - Updating NAT table from localhost to: %s&quot=
;, dot_ip);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h<br>
index ce995d9..a58da5d 100755<br>
--- a/src/openvpn/clinat.h<br>
+++ b/src/openvpn/clinat.h<br>
@@ -52,15 +52,16 @@ void copy_client_nat_option_list (struct client_nat_opt=
ion_list *dest, const str<br>
=C2=A0void print_client_nat_list(const struct client_nat_option_list *list,=
 int msglevel);<br>
=C2=A0 void add_client_nat_to_option_list (struct client_nat_option_list *d=
est,<br>
-=C2=A0 =C2=A0 const char *type,<br>
-=C2=A0 =C2=A0 const char *network,<br>
-=C2=A0 =C2=A0 const char *netmask,<br>
-=C2=A0 =C2=A0 const char *foreign_network,<br>
-=C2=A0 =C2=A0 int msglevel);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *network,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *netmask,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *foreign_network,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int msglevel);<br>
=C2=A0 void client_nat_transform (const struct client_nat_option_list *list=
,<br>
-=C2=A0 =C2=A0struct buffer *ipbuf,<br>
-=C2=A0 =C2=A0const int direction);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer *ipbuf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int direction,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const bool enable_nat_ftp_suppor=
t);<br>
=C2=A0 bool update_localhost_nat(struct client_nat_option_list *dest, in_ad=
dr_t local_ip);<br>
=C2=A0diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<br>
old mode 100644<br>
new mode 100755<br>
index 217fbb3..615db7a<br>
--- a/src/openvpn/forward.c<br>
+++ b/src/openvpn/forward.c<br>
@@ -980,9 +980,6 @@ process_incoming_tun (struct context *c)<br>
=C2=A0 =C2=A0 perf_push (PERF_PROC_IN_TUN);<br>
=C2=A0-=C2=A0 if (c-&gt;c2.buf.len &gt; 0)<br>
-=C2=A0 =C2=A0 c-&gt;c2.tun_read_bytes +=3D c-&gt;c2.buf.len;<br>
-<br>
=C2=A0#ifdef LOG_RW<br>
=C2=A0 =C2=A0if (c-&gt;c2.log_rw &amp;&amp; c-&gt;c2.buf.len &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0fprintf (stderr, &quot;r&quot;);<br>
@@ -999,6 +996,9 @@ process_incoming_tun (struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0process_ip_header (c, PIPV4_PASSTOS|PIP_MSSFIX|P=
IPV4_CLIENT_NAT, &amp;c-&gt;c2.buf);<br>
=C2=A0+=C2=A0 =C2=A0 =C2=A0 if (c-&gt;c2.buf.len &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.tun_read_bytes +=3D c-&gt;c2.buf.len;=
<br>
+<br>
=C2=A0#ifdef PACKET_TRUNCATION_CHECK<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* if (c-&gt;c2.buf.len &gt; 1) --c-&gt;c2.buf.l=
en; */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ipv4_packet_size_verify (BPTR (&amp;c-&gt;c2.buf=
),<br>
@@ -1041,43 +1041,44 @@ process_ip_header (struct context *c, unsigned int =
flags, struct buffer *buf)<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; PIP_MSSFIX)<br>
=C2=A0#endif<br>
- {<br>
-=C2=A0 struct buffer ipbuf =3D *buf;<br>
-=C2=A0 if (is_ipv4 (TUNNEL_TYPE (c-&gt;c1.tuntap), &amp;ipbuf))<br>
-=C2=A0 =C2=A0 {<br>
-#if PASSTOS_CAPABILITY<br>
-=C2=A0 =C2=A0 =C2=A0 /* extract TOS from IP header */<br>
-=C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIPV4_PASSTOS)<br>
- link_socket_extract_tos (c-&gt;c2.link_socket, &amp;ipbuf);<br>
-#endif<br>
-=C2=A0 -=C2=A0 =C2=A0 =C2=A0 /* possibly alter the TCP MSS */<br>
-=C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIP_MSSFIX)<br>
- mss_fixup_ipv4 (&amp;ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;=
c2.frame)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_ipv4 (TUNNEL_TYPE (c-&gt;c1.tunt=
ap), buf))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 #ifdef ENABLE_CLIENT_NAT<br>
-=C2=A0 =C2=A0 =C2=A0 /* possibly do NAT on packet */<br>
-=C2=A0 =C2=A0 =C2=A0 if ((flags &amp; PIPV4_CLIENT_NAT) &amp;&amp; c-&gt;o=
ptions.client_nat)<br>
- {<br>
-=C2=A0 const int direction =3D (flags &amp; PIPV4_OUTGOING) ? CN_INCOMING =
: CN_OUTGOING;<br>
-=C2=A0 client_nat_transform (c-&gt;options.client_nat, &amp;ipbuf, directi=
on);<br>
- }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possibly do NAT on pac=
ket */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((flags &amp; PIPV4_CL=
IENT_NAT) &amp;&amp; c-&gt;options.client_nat)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int d=
irection =3D (flags &amp; PIPV4_OUTGOING) ? CN_INCOMING : CN_OUTGOING;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 client_nat_=
transform(c-&gt;options.client_nat, buf, direction, c-&gt;options.enable_na=
t_ftp_support);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 /* possibly extract a DHCP router message */<br>
-=C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIPV4_EXTRACT_DHCP_ROUTER)<br>
- {<br>
-=C2=A0 const in_addr_t dhcp_router =3D dhcp_extract_router_msg (&amp;ipbuf=
);<br>
-=C2=A0 if (dhcp_router)<br></div></div>
-=C2=A0 =C2=A0 route_list_add_vpn_gateway (c-&gt;c1.route_list, c-&gt;<a hr=
ef=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a> &lt;<a h=
ref=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">http://c2.es</a>&=
gt;, dhcp_router);<div><div class=3D"h5"><br>
- }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 else if (is_ipv6 (TUNNEL_TYPE (c-&gt;c1.tuntap), &amp;ipbuf))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 /* possibly alter the TCP MSS */<br>
-=C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIP_MSSFIX)<br>
- mss_fixup_ipv6 (&amp;ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;=
c2.frame)));<br>
-=C2=A0 =C2=A0 }<br>
- }<br>
+<br>
+#if PASSTOS_CAPABILITY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* extract TOS from IP he=
ader */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIPV4_PAS=
STOS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_socket_extrac=
t_tos (c-&gt;c2.link_socket, buf);<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possibly alter the TCP=
 MSS */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIP_MSSFI=
X)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mss_fixup_ipv4 (bu=
f, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;c2.frame)));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possibly extract a DHC=
P router message */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIPV4_EXT=
RACT_DHCP_ROUTER)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const in_ad=
dr_t dhcp_router =3D dhcp_extract_router_msg (buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dhcp_ro=
uter)<br></div></div>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rout=
e_list_add_vpn_gateway (c-&gt;c1.route_list, c-&gt;<a href=3D"http://c2.es"=
 rel=3D"noreferrer" target=3D"_blank">c2.es</a> &lt;<a href=3D"http://c2.es=
" rel=3D"noreferrer" target=3D"_blank">http://c2.es</a>&gt;, dhcp_router);<=
div><div class=3D"h5"><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (is_ipv6 (TUNNEL_TYPE (c-&gt;c1=
.tuntap), buf))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possibly alter the TCP=
 MSS */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; PIP_MSSFI=
X)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mss_fixup_ipv6 (bu=
f, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;c2.frame)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
=C2=A0diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
old mode 100644<br>
new mode 100755<br>
index 007bd8c..73b615a<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -236,6 +236,7 @@ static const char usage_message[] =3D<br>
=C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 the default gateway.=C2=A0 Useful when pushing private subnets.\n&qu=
ot;<br>
=C2=A0#ifdef ENABLE_CLIENT_NAT<br>
=C2=A0 =C2=A0&quot;--client-nat snat|dnat network netmask alias : on client=
 add 1-to-1 NAT rule.\n&quot;<br>
+=C2=A0 &quot;--enable-nat-ftp-support : Enable NAT FTP Support, updating t=
he IP address on FTP PORT commands or PASV responses\n&quot;=C2=A0 =C2=A0#e=
ndif<br>
=C2=A0#ifdef ENABLE_PUSH_PEER_INFO<br>
=C2=A0 =C2=A0&quot;--push-peer-info : (client only) push client info to ser=
ver.\n&quot;<br>
@@ -789,6 +790,11 @@ init_options (struct options *o, const bool init_gc)<b=
r>
=C2=A0 =C2=A0o-&gt;max_routes =3D MAX_ROUTES_DEFAULT;<br>
=C2=A0 =C2=A0o-&gt;resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;<br>
=C2=A0 =C2=A0o-&gt;proto_force =3D -1;<br>
+<br>
+#ifdef ENABLE_CLIENT_NAT<br>
+=C2=A0 o-&gt;enable_nat_ftp_support =3D false;<br>
+#endif<br>
+=C2=A0 =C2=A0#ifdef ENABLE_OCC<br>
=C2=A0 =C2=A0o-&gt;occ =3D true;<br>
=C2=A0#endif<br>
@@ -1535,6 +1541,8 @@ show_settings (const struct options *o)<br>
=C2=A0#ifdef ENABLE_CLIENT_NAT<br>
=C2=A0 =C2=A0if (o-&gt;client_nat)<br>
=C2=A0 =C2=A0 =C2=A0print_client_nat_list(o-&gt;client_nat, D_SHOW_PARMS);<=
br>
+<br>
+=C2=A0 SHOW_BOOL(enable_nat_ftp_support);<br>
=C2=A0#endif<br>
=C2=A0 #ifdef ENABLE_MANAGEMENT<br>
@@ -5287,6 +5295,10 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0cnol_check_alloc (options);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0add_client_nat_to_option_list(options-&gt;client=
_nat, p[1], p[2], p[3], p[4], msglevel);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 else if (streq (p[0], &quot;enable_nat_ftp_support&quot;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 options-&gt;enable_nat_ftp_support =3D true;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0else if (streq (p[0], &quot;route&quot;) &amp;&amp; p[1])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
old mode 100644<br>
new mode 100755<br>
index af9a47f..2b27368<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -347,6 +347,7 @@ struct options<br>
=C2=A0 =C2=A0bool allow_pull_fqdn; /* as a client, allow server to push a F=
QDN for certain parameters */<br>
=C2=A0 #ifdef ENABLE_CLIENT_NAT<br>
+=C2=A0 bool enable_nat_ftp_support;<br>
=C2=A0 =C2=A0struct client_nat_option_list *client_nat;<br>
=C2=A0#endif<br>
=C2=A0<br>
-- <br>
1.7.9.5<br>
<br>
<br>
From 0aa64f57ecf653cd067dbef2b2378bdfc4f9a754 Mon Sep 17 00:00:00 2001<br>=
</div></div>
From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=
=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"mailto:raf=
ael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a>&g=
t;&gt;<span class=3D""><br>
Date: Fri, 14 Aug 2015 16:46:13 -0300<br>
Subject: [PATCH] Removed debug messages.<br>
<br>
<br></span>
Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056...=
" target=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;&gt;<span class=3D""><br>
---<br>
=C2=A0src/openvpn/clinat.c |=C2=A0 =C2=A0 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>
index 1d213f5..991ea75 100755<br>
--- a/src/openvpn/clinat.c<br>
+++ b/src/openvpn/clinat.c<br>
@@ -833,7 +833,9 @@ client_nat_ftp_transform(struct buffer *ipbuf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (OPENVPN_TCPH_FIN_MASK &amp; hd=
r-&gt;u.tcp.flags)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;marked_to_=
remove =3D 1;<br>
+#if DEBUG_DELTA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;Delta marke=
d to be removed!&quot;);<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 1; <br>
-- <br>
1.7.9.5<br>
<br>
<br>
From cf7af4e4784c83a64b8c1e12601d33bdc5b14d59 Mon Sep 17 00:00:00 2001<br>=
</span>
From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=
=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"mailto:raf=
ael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a>&g=
t;&gt;<span class=3D""><br>
Date: Thu, 20 Aug 2015 08:47:08 -0300<br>
Subject: [PATCH] Fixed FTP NAT IP address.<br>
<br>
<br></span>
Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056...=
" target=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;&gt;<div><div class=3D"h5"><br>
---<br>
=C2=A0src/openvpn/clinat.c |=C2=A0 =C2=A030 +++++++++++++++---------------<=
br>
=C2=A01 file changed, 15 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<br>
index 991ea75..ef400de 100755<br>
--- a/src/openvpn/clinat.c<br>
+++ b/src/openvpn/clinat.c<br>
@@ -423,7 +423,7 @@ static int try_number(const char *data, size_t dlen, ui=
nt32_t array[],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*data =3D=3D term &amp;&amp; i =3D=3D array_=
size - 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;<br>
=C2=A0-=C2=A0 =C2=A0 =C2=A0 msg (M_ERRNO, &quot;CNAT - try_number - Char %u=
 (got %u nums) `%u&#39; unexpected\n&quot;, len, i, *data);<br>
+=C2=A0 =C2=A0 =C2=A0 msg (M_ERRNO, &quot;CNAT - try_number - Char %u (got =
%u nums) &#39;%u&#39; unexpected\n&quot;, len, i, *data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0}<br>
@@ -433,7 +433,7 @@ static int try_number(const char *data, size_t dlen, ui=
nt32_t array[],<br>
=C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
=C2=A0-static int try_rfc959(const char *, size_t, u_int32_t [], char);<br>
+static int try_rfc959(const char *, size_t, uint32_t [], char);<br>
=C2=A0 static struct ftp_search {<br>
=C2=A0 =C2=A0int direction;<br>
@@ -441,7 +441,7 @@ static struct ftp_search {<br>
=C2=A0 =C2=A0size_t plen;<br>
=C2=A0 =C2=A0char skip;<br>
=C2=A0 =C2=A0char term;<br>
-=C2=A0 int (*getnum)(const char *, size_t, u_int32_t[], char);<br>
+=C2=A0 int (*getnum)(const char *, size_t, uint32_t[], char);<br>
=C2=A0} search[] =3D {<br>
=C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CN_OUTGOING,<br>
@@ -458,7 +458,7 @@ static struct ftp_search {<br>
=C2=A0 /* Returns 0, or length of numbers: 192,168,1,1,5,6 */<br>
=C2=A0static int -try_rfc959(const char *data, size_t dlen, u_int32_t array=
[6],<br>
+try_rfc959(const char *data, size_t dlen, uint32_t array[6],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char term)<br>
=C2=A0{<br>
=C2=A0 =C2=A0return try_number(data, dlen, array, 6, &#39;,&#39;, term);<br>
@@ -467,9 +467,9 @@ try_rfc959(const char *data, size_t dlen, u_int32_t arr=
ay[6],<br>
=C2=A0/* Grab port: number up to delimiter */<br>
=C2=A0static int=C2=A0 get_port(const char *data, int start, size_t dlen, c=
har delim,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 u_int32_t array[2])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t array[2])<br>
=C2=A0{<br>
-=C2=A0 u_int16_t port =3D 0;<br>
+=C2=A0 uint16_t port =3D 0;<br>
=C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 for (i =3D start; i &lt; dlen; i++) {<br>
@@ -496,13 +496,13 @@ find_pattern(const char *data, size_t dlen,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0char skip, char term,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *numoff,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *numlen,<br>
-=C2=A0 =C2=A0 =C2=A0 u_int32_t array[6],<br>
-=C2=A0 =C2=A0 =C2=A0 int (*getnum)(const char *, size_t, u_int32_t[], char=
))<br>
+=C2=A0 =C2=A0 =C2=A0 uint32_t array[6],<br>
+=C2=A0 =C2=A0 =C2=A0 int (*getnum)(const char *, size_t, uint32_t[], char)=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0size_t i;<br>
=C2=A0 =C2=A0 if (check_debug_level (D_CLIENT_NAT))<br>
-=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - find_pattern %s: dlen =3D %u\n&quo=
t;, pattern, dlen);<br>
+=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - find_pattern %s: dlen =3D %u\n&quo=
t;, pattern, (uint32_t) dlen);<br>
=C2=A0 =C2=A0 if (dlen =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -530,7 +530,7 @@ find_pattern(const char *data, size_t dlen,<br>
=C2=A0 =C2=A0i++;<br>
=C2=A0 =C2=A0 if (check_debug_level (D_CLIENT_NAT))<br>
-=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - Skipped up to `%c&#39;!\n&quot;, s=
kip);<br>
+=C2=A0 =C2=A0 msg (M_INFO, &quot;CNAT - Skipped up to &#39;%c&#39; (%d)!\n=
&quot;, skip, skip);<br>
=C2=A0 =C2=A0 *numoff =3D i;<br>
=C2=A0 =C2=A0*numlen =3D getnum(data + i, dlen - i, array, term);<br>
@@ -652,7 +652,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,<br>
=C2=A0 =C2=A0hexdump(tcp_data, BLEN(&amp;tcpbuf));=C2=A0 =C2=A0 =C2=A0#endi=
f<br>
=C2=A0-=C2=A0 u_int32_t matchlen, matchoff;<br>
+=C2=A0 uint32_t matchlen, matchoff;<br>
=C2=A0 =C2=A0int found_pattern =3D -1;<br>
=C2=A0 =C2=A0int i =3D 0;<br>
=C2=A0@@ -689,7 +689,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t new_tcp_data[32];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;new_tcp_data[0], 0, sizeof(new_tcp_d=
ata));<br>
=C2=A0-=C2=A0 =C2=A0 =C2=A0 int new_len =3D sprintf((char *) &amp;new_tcp_d=
ata[0], &quot;%d,%d,%d,%d,%d,%d%.*s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 int new_len =3D sprintf((char *) &amp;new_tcp_data[0]=
, &quot;%03d,%03d,%03d,%03d,%03d,%03d%.*s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_tmp[0], addr_tmp[1], addr_tmp[2], ad=
dr_tmp[3], array[4], array[5],=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_len -=
 matchlen, (char *)&amp;tcp_data[matchoff + matchlen]);<br>
=C2=A0@@ -700,7 +700,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 //If the new len is greater than the old, there=
 will be there an adjustment<br>
-=C2=A0 =C2=A0 =C2=A0 if (new_len &gt; data_len) +=C2=A0 =C2=A0 =C2=A0 if (=
replace_address !=3D ip &amp;&amp; new_len &gt; data_len)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//If the entry already exists<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry =3D get_delta_entry(tabl=
e, delta_key)) @@ -765,8 +765,8 @@ client_nat_ftp_transform(struct buffer *=
ipbuf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // The replace size is the lesser or iq=
ual the original? Pad with 0 if necessary.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;tcp_data[matchoff], new_tcp=
_data, data_len); +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (replace_address !=
=3D ip)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;tcp_data[matchoff], =
new_tcp_data, data_len);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//I=
f the entry already exists<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry =3D get_delta_entry(tabl=
e, delta_key)) <br>
-- <br>
1.7.9.5<br>
<br>
<br>
From 63b1ddad1628eb1a179c2bf5010b781284d2bc4f Mon Sep 17 00:00:00 2001<br>=
</div></div>
From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=
=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"mailto:raf=
ael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a>&g=
t;&gt;<span class=3D""><br>
Date: Sat, 15 Aug 2015 16:58:45 -0300<br>
Subject: [PATCH] Fixed options parameter name enable-nat-ftp-support.<br>
<br>
<br></span>
Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056...=
" target=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;&gt;<span class=3D""><br>
---<br>
=C2=A0src/openvpn/options.c |=C2=A0 =C2=A0 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 73b615a..1a012e4 100755<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -5295,7 +5295,7 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0cnol_check_alloc (options);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0add_client_nat_to_option_list(options-&gt;client=
_nat, p[1], p[2], p[3], p[4], msglevel);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 else if (streq (p[0], &quot;enable_nat_ftp_support&quot;))<br>
+=C2=A0 else if (streq (p[0], &quot;enable-nat-ftp-support&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;enable_nat_ftp_support =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
1.7.9.5<br>
<br>
<br>
From 2f5ac96c0c2c5d9d06a11e0b08ae958e09c2e9b5 Mon Sep 17 00:00:00 2001<br>=
</span>
From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=
=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"mailto:raf=
ael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a>&g=
t;&gt;<span class=3D""><br>
Date: Mon, 24 Aug 2015 09:15:34 -0300<br>
Subject: [PATCH] Allows set yes/no option to enable-nat-ftp-support feature=
.<br>
<br>
<br></span>
Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2056...=
" target=3D"_blank">rafael.oliveira@...2056...</a> &lt;mailto:<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;&gt;<div><div class=3D"h5"><br>
---<br>
=C2=A0src/openvpn/options.c |=C2=A0 =C2=A021 +++++++++++++++++++--<br>
=C2=A01 file changed, 19 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 1a012e4..4d73d87 100755<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -236,7 +236,9 @@ static const char usage_message[] =3D<br>
=C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 the default gateway.=C2=A0 Useful when pushing private subnets.\n&qu=
ot;<br>
=C2=A0#ifdef ENABLE_CLIENT_NAT<br>
=C2=A0 =C2=A0&quot;--client-nat snat|dnat network netmask alias : on client=
 add 1-to-1 NAT rule.\n&quot;<br>
-=C2=A0 &quot;--enable-nat-ftp-support : Enable NAT FTP Support, updating t=
he IP address on FTP PORT commands or PASV responses\n&quot;=C2=A0 +=C2=A0 =
&quot;--enable-nat-ftp-support : Enable NAT FTP Support, replacing the IP a=
ddress on FTP PORT commands or PASV responses?\n&quot;=C2=A0 +=C2=A0 &quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;no&#39;=
=C2=A0 =C2=A0 -- No, disable this feature.\n&quot;<br>
+=C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;yes&#39;=C2=A0 =C2=A0-- Yes, enable this feature (Enabled by defau=
lt on Windows).\n&quot;<br>
=C2=A0#endif<br>
=C2=A0#ifdef ENABLE_PUSH_PEER_INFO<br>
=C2=A0 =C2=A0&quot;--push-peer-info : (client only) push client info to ser=
ver.\n&quot;<br>
@@ -792,8 +794,12 @@ init_options (struct options *o, const bool init_gc)<b=
r>
=C2=A0 =C2=A0o-&gt;proto_force =3D -1;<br>
=C2=A0 #ifdef ENABLE_CLIENT_NAT<br>
+#ifdef WIN32<br>
+=C2=A0 o-&gt;enable_nat_ftp_support =3D true;<br>
+#else<br>
=C2=A0 =C2=A0o-&gt;enable_nat_ftp_support =3D false;<br>
=C2=A0#endif<br>
+#endif<br>
=C2=A0 =C2=A0 #ifdef ENABLE_OCC<br>
=C2=A0 =C2=A0o-&gt;occ =3D true;<br>
@@ -5297,7 +5303,18 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0else if (streq (p[0], &quot;enable-nat-ftp-support&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 options-&gt;enable_nat_ftp_support =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 if (p[1])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (streq (p[1], &quot;yes&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;enable_nat_ftp_suppo=
rt =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (streq (p[1], &quot;no&quot;))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;enable_nat_ftp_suppo=
rt =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (msglevel, &quot;bad =
enable-nat-ftp-support option: %s -- must be &#39;yes&#39; or &#39;no&#39;&=
quot;, p[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0else if (streq (p[0], &quot;route&quot;) &amp;&amp; p[1])<br>
-- <br>
1.7.9.5<br>
<br>
<br></div></div>
------------------------------------------------------------------------<br>
<br>
---------------------------------------------------------------------------=
---<br>
=C2=A0 --------------------------------------------------------------------=
----<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
=C2=A0 <br>
</blockquote>
<br>
</blockquote></div><br></div></div></div>

--001a113fd83af6592b051e38d1ac--

