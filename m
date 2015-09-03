MIME-Version: 1.0
In-Reply-To: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
Date: Thu, 3 Sep 2015 16:28:01 -0300
Message-ID: <CAAWBBYO7Fc3Q8fLnbZUv5cYMEEHirWggWUB8AoFf2i0MGZAr3Q@...278...>
From: Rafael Gava <gava100@...277...>
Content-Type: multipart/alternative; boundary=047d7bd76c0010b3ec051edcc8b1
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
To: openvpn-devel@lists.sourceforge.net

--047d7bd76c0010b3ec051edcc8b1
Content-Type: text/plain; charset=UTF-8

Hello All,

I'm looking forward to hearing from you guys a feedback if the patch for
the features added to the NAT will be accepted or not or if is there
anything else that I need to do or change in order to have it merged into
the code.

From the previous replies, it seems that a minor change was requested to
replace the localhost string with client-ip.

Anything else?

Thanks in advance,

Rafael

On Tue, Aug 25, 2015 at 10:43 PM, Rafael Gava <gava100@...277...> wrote:

> Hi,
>
> this is my first submission to the list and I hope that I'm doing in the
> right way. :-)
>
>
> Well, the features added to Network Address Translator are:
>
> 1) Allow the user to use the string "localhost" on the client-nat network
> configuration in a way that is not necessary to inform the IP address
> beforehand. Openvpn will set the dynamic received IP from DHCP.
> Example:
>
> client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
> 'localhost' string with the DHCP address received from openvpn server.
>
> 2) Allow the user to enable the FTP NAT support through the
> --enable-nat-ftp-support option.
> This is useful for systems that don't have conntrack-tools support, for
> example on Windows systems. On windows this feature is enabled by default.
>
> enable-nat-ftp-support (yes | no)
>
>
> The following patch was written based on release/2.3 branch.
>
> --------------------------------------------------------------------------------------------------------------------------------------
>
> From d11957a025dc6c113874e7b04ce4c8e9513c3b02 Mon Sep 17 00:00:00 2001
> From: venturus <venturus@...2055...(none)>
> Date: Thu, 13 Aug 2015 08:26:36 -0300
> Subject: [PATCH] Replaces the client-nat network string 'localhost' with
> the
>  dynamic IP set to the tun/tap interface by the openvpn
>  server. Example:
>
> --client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
> 'localhost' string with the DHCP address received from openvpn server.
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
> ---
>  src/openvpn/clinat.c |   57
> ++++++++++++++++++++++++++++++++++++++++++--------
>  src/openvpn/clinat.h |    2 ++
>  src/openvpn/init.c   |    4 ++++
>  3 files changed, 54 insertions(+), 9 deletions(-)
>  mode change 100644 => 100755 src/openvpn/clinat.c
>  mode change 100644 => 100755 src/openvpn/clinat.h
>  mode change 100644 => 100755 src/openvpn/init.c
>
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> old mode 100644
> new mode 100755
> index af75fc9..2460185
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -107,11 +107,11 @@ copy_client_nat_option_list (struct
> client_nat_option_list *dest,
>
>  void
>  add_client_nat_to_option_list (struct client_nat_option_list *dest,
> -      const char *type,
> -      const char *network,
> -      const char *netmask,
> -      const char *foreign_network,
> -      int msglevel)
> +            const char *type,
> +            const char *network,
> +            const char *netmask,
> +            const char *foreign_network,
> +            int msglevel)
>  {
>    struct client_nat_entry e;
>    bool ok;
> @@ -126,12 +126,19 @@ add_client_nat_to_option_list (struct
> client_nat_option_list *dest,
>        return;
>      }
>
> -  e.network = getaddr(0, network, 0, &ok, NULL);
> -  if (!ok)
> +  if (network && !strcmp(network, "localhost"))
>      {
> -      msg(msglevel, "client-nat: bad network: %s", network);
> -      return;
> +      msg (M_INFO, "*** client-nat localhost detected...");
> +      e.network = 0xFFFFFFFF;
> +    } else {
> +      e.network = getaddr(0, network, 0, &ok, NULL);
> +      if (!ok)
> +      {
> +        msg(msglevel, "client-nat: bad network: %s", network);
> +        return;
> +      }
>      }
> +
>    e.netmask = getaddr(0, netmask, 0, &ok, NULL);
>    if (!ok)
>      {
> @@ -148,6 +155,7 @@ add_client_nat_to_option_list (struct
> client_nat_option_list *dest,
>    add_entry(dest, &e);
>  }
>
> +
>  #if 0
>  static void
>  print_checksum (struct openvpn_iphdr *iph, const char *prefix)
> @@ -266,4 +274,35 @@ client_nat_transform (const struct
> client_nat_option_list *list,
>      }
>  }
>
> +/*
> +* Replaces the localhost token with the IP received from OpenVPN
> +*/
> +bool
> +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip)
> +{
> +  int i;
> +  bool ret = false;
> +
> +  if (!dest)
> +    return ret;
> +
> +  for (i=0; i <= dest->n; i++)
> +    {
> +      struct client_nat_entry *nat_entry = &dest->entries[i];
> +      if (nat_entry && nat_entry->network == 0xFFFFFFFF)
> +        {
> +          struct in_addr addr;
> +
> +          nat_entry->network = ntohl(local_ip);
> +          addr.s_addr = nat_entry->network;
> +          char *dot_ip = inet_ntoa(addr);
> +
> +          msg (M_INFO, "Updating NAT table from localhost to: %s",
> dot_ip);
> +          ret = true;
> +        }
> +    }
> +
> +  return ret;
> +}
> +
>  #endif
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> old mode 100644
> new mode 100755
> index d55a727..ce995d9
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -62,4 +62,6 @@ void client_nat_transform (const struct
> client_nat_option_list *list,
>     struct buffer *ipbuf,
>     const int direction);
>
> +bool update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip);
> +
>  #endif
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> old mode 100644
> new mode 100755
> index 71c91a2..4a63ee8
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1476,6 +1476,10 @@ do_open_tun (struct context *c)
>         c->c1.tuntap->post_open_mtu,
>         SET_MTU_TUN | SET_MTU_UPPER_BOUND);
>
> +#ifdef ENABLE_CLIENT_NAT
> +      update_localhost_nat(c->options.client_nat, c->c1.tuntap->local);
> +#endif
> +
>        ret = true;
>        static_context = c;
>      }
> --
> 1.7.9.5
>
>
> From 18b1411689df67feafeb15630c3519ab2cbd42d4 Mon Sep 17 00:00:00 2001
> From: Rafael Gava <rafael.oliveira@...2056...>
> Date: Fri, 14 Aug 2015 15:27:50 -0300
> Subject: [PATCH] Added FTP NAT support. This feature can be enabled via
>  --enable-nat-ftp-support option.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
> ---
>  src/openvpn/clinat.c  |  773
> ++++++++++++++++++++++++++++++++++++++++++++++---
>  src/openvpn/clinat.h  |   15 +-
>  src/openvpn/forward.c |   75 ++---
>  src/openvpn/options.c |   12 +
>  src/openvpn/options.h |    1 +
>  5 files changed, 787 insertions(+), 89 deletions(-)
>  mode change 100644 => 100755 src/openvpn/forward.c
>  mode change 100644 => 100755 src/openvpn/options.c
>  mode change 100644 => 100755 src/openvpn/options.h
>
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 2460185..1d213f5 100755
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -36,6 +36,159 @@
>  #include "proto.h"
>  #include "socket.h"
>  #include "memdbg.h"
> +#include <stdio.h>
> +#include <ctype.h>
> +#include <string.h>
> +
> +/* Delta Table Types */
> +
> +typedef struct delta_table_key {
> +  uint32_t src_addr;
> +  uint32_t dest_addr;
> +  uint16_t src_port;
> +  uint16_t dest_port;
> +} delta_table_key_t;
> +
> +typedef struct delta_table_entry {
> +  delta_table_key_t key;
> +  uint16_t delta_out;
> +  uint16_t delta_in;
> +  uint8_t marked_to_remove;
> +  uint8_t reserved[3];
> +  uint32_t timestamp;
> +  struct delta_table_entry *_next;
> +} delta_table_entry_t;
> +
> +typedef struct delta_table {
> +    struct delta_table_entry *head;
> +} delta_table_t;
> +
> +
> +// Global delta table
> +//#define DEBUG_DELTA 1
> +
> +delta_table_t *table = NULL;
> +
> +#define TIME_TO_RESPOND 60 * 5 // 5 Minutes
> +#define TIME_TO_LIVE 24 * 60 * 60
> +
> +/* Delta Table Functions */
> +
> +// In seconds, since epoch
> +static uint32_t
> +get_timestamp() {
> +  return (uint32_t)time(NULL);
> +}
> +
> +static void
> +print_delta_table_entries(delta_table_t *table) {
> +    delta_table_entry_t *current = table->head;
> +
> +  if (current == NULL) {
> +    return;
> +  }
> +
> +  while (current != NULL) {
> +    printf("from %d -> to %d: removed: %s, timestamp: %d, delta_out: %d,
> delta_in: %d\n",
> +      current->key.src_addr, current->key.dest_addr,
> current->marked_to_remove ? "true" : "false",
> +      current->timestamp, current->delta_out, current->delta_in);
> +    current = current->_next;
> +  }
> +}
> +
> +static struct delta_table *
> +init_delta_table() {
> +  delta_table_t *table = malloc(sizeof(delta_table_t));
> +  table->head = NULL;
> +  return table;
> +}
> +
> +static struct delta_table_entry *
> +add_delta_entry(delta_table_t *table, delta_table_entry_t
> *new_delta_entry) {
> +  if (table->head == NULL) {
> +    table->head = new_delta_entry;
> +    table->head->_next = NULL;
> +  } else {
> +    // Add element to HEAD, for performance gain
> +    new_delta_entry->_next = table->head;
> +    table->head = new_delta_entry;
> +  }
> +  return new_delta_entry;
> +}
> +
> +static int
> +remove_delta_entry(delta_table_t *table, delta_table_entry_t
> *delta_entry) {
> +  delta_table_entry_t *current = table->head;
> +  delta_table_entry_t *before = NULL;
> +  uint8_t found = 0;
> +
> +  //msg (M_INFO, "On remove_delta_entry - entry: %p", &delta_entry);
> +
> +  while (current != NULL) {
> +    if(current == delta_entry) {
> +      found = 1;
> +      break;
> +    }
> +    before = current;
> +    current = current->_next;
> +  }
> +
> +  //Element not found
> +  if (!found) {
> +    return 0;
> +  }
> +
> +  if(before==NULL){
> +    table->head = table->head->_next;
> +  } else {
> +    before->_next = delta_entry->_next;
> +  }
> +
> +  //msg (M_INFO, "On remove_delta_entry - entry: %p - freed",
> &delta_entry);
> +
> +  free(delta_entry);
> +  return 1;
> +}
> +
> +static struct delta_table_entry *
> +get_delta_entry(delta_table_t *table, delta_table_key_t key) {
> +  delta_table_entry_t *current = table->head;
> +  delta_table_entry_t *aux = NULL;
> +  delta_table_entry_t *el = NULL;
> +
> +  while (current != NULL) {
> +    // Check TTL and Timeout
> +    if ((current->marked_to_remove && get_timestamp() -
> current->timestamp >= TIME_TO_RESPOND) /* ||  get_timestamp() -
> current->timestamp >= TIME_TO_LIVE */){
> +      aux = current;
> +      //If the CURRENT is to be removed, then dont return it
> +      if (aux == el) {
> +        el = NULL;
> +      }
> +      current = current->_next;
> +      remove_delta_entry(table, aux);
> +    } else {
> +      if ((
> +        // Regular connection
> +        (current->key.src_addr == key.src_addr &&
> +         current->key.src_port == key.src_port &&
> +         current->key.dest_addr == key.dest_addr &&
> +         current->key.dest_port == key.dest_port) ||
> +        //Check if it is a returned connection
> +        (current->key.dest_addr == key.src_addr &&
> +         current->key.dest_port == key.src_port &&
> +         current->key.src_addr == key.dest_addr &&
> +         current->key.src_port == key.dest_port))) {
> +        el = current;
> +      }
> +      current = current->_next;
> +    }
> +  }
> +
> +  return el;
> +}
> +
> +/* Delta Table Functions End */
> +
>
>  static bool
>  add_entry(struct client_nat_option_list *dest,
> @@ -192,19 +345,533 @@ print_pkt (struct openvpn_iphdr *iph, const char
> *prefix, const int direction, c
>    gc_free (&gc);
>  }
>
> +#if DEBUG_DELTA
> +
> +#ifndef HEXDUMP_COLS
> +#define HEXDUMP_COLS 8
> +#endif
> +
> +static void hexdump(void *mem, unsigned int len)
> +{
> +  unsigned int i, j;
> +
> +  for(i = 0; i < len + ((len % HEXDUMP_COLS) ? (HEXDUMP_COLS - len %
> HEXDUMP_COLS) : 0); i++)
> +  {
> +    /* print offset */
> +    if(i % HEXDUMP_COLS == 0)
> +    {
> +      printf("0x%06x: ", i);
> +    }
> +
> +    /* print hex data */
> +    if(i < len)
> +    {
> +      printf("%02x ", 0xFF & ((char*)mem)[i]);
> +    }
> +    else /* end of block, just aligning for ASCII dump */
> +    {
> +      printf("   ");
> +    }
> +
> +    /* print ASCII dump */
> +    if(i % HEXDUMP_COLS == (HEXDUMP_COLS - 1))
> +    {
> +      for(j = i - (HEXDUMP_COLS - 1); j <= i; j++)
> +      {
> +        unsigned char ch = 0xFF & ((char*)mem)[j];
> +
> +        if(j >= len) /* end of block, not really printing */
> +        {
> +          putchar(' ');
> +        }
> +        else if (ch >= 0x80)
> +        {
> +          putchar('.');
> +        }
> +        else if(isprint(((char*)mem)[j])) /* printable char */
> +        {
> +          putchar(0xFF & ((char*)mem)[j]);
> +        }
> +        else /* other char */
> +        {
> +          putchar('.');
> +        }
> +      }
> +      putchar('\n');
> +    }
> +  }
> +}
> +#endif
> +
> +static int try_number(const char *data, size_t dlen, uint32_t array[],
> +          int array_size, char sep, char term)
> +{
> +  uint32_t i, len;
> +
> +  memset(array, 0, sizeof(array[0])*array_size);
> +
> +  /* Keep data pointing at next char. */
> +  for (i = 0, len = 0; len < dlen && i < array_size; len++, data++) {
> +    if (*data >= '0' && *data <= '9') {
> +      array[i] = array[i]*10 + *data - '0';
> +    }
> +    else if (*data == sep)
> +      i++;
> +    else {
> +      /* Unexpected character; true if it's the
> +         terminator and we're finished. */
> +      if (*data == term && i == array_size - 1)
> +        return len;
> +
> +      msg (M_ERRNO, "CNAT - try_number - Char %u (got %u nums) `%u'
> unexpected\n", len, i, *data);
> +      return 0;
> +    }
> +  }
> +
> +  msg (M_ERRNO, "CNAT - ERROR: Failed to fill %u numbers separated by
> %c\n", array_size, sep);
> +
> +  return 0;
> +}
> +
> +static int try_rfc959(const char *, size_t, u_int32_t [], char);
> +
> +static struct ftp_search {
> +  int direction;
> +  const char *pattern;
> +  size_t plen;
> +  char skip;
> +  char term;
> +  int (*getnum)(const char *, size_t, u_int32_t[], char);
> +} search[] = {
> +  {
> +    CN_OUTGOING,
> +    "PORT",  sizeof("PORT") - 1, ' ', '\r',
> +    try_rfc959,
> +  },
> +  {
> +    CN_INCOMING,
> +    "227 ",  sizeof("227 ") - 1, '(', ')',
> +    try_rfc959,
> +  },
> +};
> +
> +
> +/* Returns 0, or length of numbers: 192,168,1,1,5,6 */
> +static int
> +try_rfc959(const char *data, size_t dlen, u_int32_t array[6],
> +           char term)
> +{
> +  return try_number(data, dlen, array, 6, ',', term);
> +}
> +
> +/* Grab port: number up to delimiter */
> +static int
> +get_port(const char *data, int start, size_t dlen, char delim,
> +        u_int32_t array[2])
> +{
> +  u_int16_t port = 0;
> +  int i;
> +
> +  for (i = start; i < dlen; i++) {
> +    /* Finished? */
> +    if (data[i] == delim) {
> +      if (port == 0)
> +        break;
> +      array[0] = port >> 8;
> +      array[1] = port;
> +      return i + 1;
> +    }
> +    else if (data[i] >= '0' && data[i] <= '9')
> +      port = port*10 + data[i] - '0';
> +    else /* Some other crap */
> +      break;
> +  }
> +  return 0;
> +}
> +
> +/* Return 1 for match, 0 for accept, -1 for partial. */
> +static int
> +find_pattern(const char *data, size_t dlen,
> +      const char *pattern, size_t plen,
> +      char skip, char term,
> +      unsigned int *numoff,
> +      unsigned int *numlen,
> +      u_int32_t array[6],
> +      int (*getnum)(const char *, size_t, u_int32_t[], char))
> +{
> +  size_t i;
> +
> +  if (check_debug_level (D_CLIENT_NAT))
> +    msg (M_INFO, "CNAT - find_pattern %s: dlen = %u\n", pattern, dlen);
> +
> +  if (dlen == 0)
> +    return 0;
> +
> +  if (dlen <= plen) {
> +    /* Short packet: try for partial? */
> +    if (strncasecmp(data, pattern, dlen) == 0)
> +      return -1;
> +    else return 0;
> +  }
> +
> +  if (strncasecmp(data, pattern, plen) != 0) {
> +    return 0;
> +  }
> +
> +  if (check_debug_level (D_CLIENT_NAT))
> +    msg (M_INFO, "CNAT - Pattern matches!\n");
> +
> +  /* Now we've found the constant string, try to skip
> +     to the 'skip' character */
> +  for (i = plen; data[i] != skip; i++)
> +    if (i == dlen - 1) return -1;
> +
> +  /* Skip over the last character */
> +  i++;
> +
> +  if (check_debug_level (D_CLIENT_NAT))
> +    msg (M_INFO, "CNAT - Skipped up to `%c'!\n", skip);
> +
> +  *numoff = i;
> +  *numlen = getnum(data + i, dlen - i, array, term);
> +  if (!*numlen)
> +    return -1;
> +
> +  if (check_debug_level (D_CLIENT_NAT))
> +    msg (M_INFO, "CNAT - Match succeeded!\n");
> +
> +  return 1;
> +}
> +
> +static uint16_t
> +tcp_checksum (const uint8_t *buf,
> +        const int len_tcp,
> +        const uint32_t src_addr,
> +        const uint32_t dest_addr)
> +{
> +  uint16_t word16;
> +  uint32_t sum = 0;
> +  int i;
> +  uint8_t * psrc_addr = (uint8_t *) &src_addr;
> +  uint8_t * pdest_addr = (uint8_t *) &dest_addr;
> +
> +  /* make 16 bit words out of every two adjacent 8 bit words and  */
> +  /* calculate the sum of all 16 bit words */
> +  for (i = 0; i < len_tcp; i += 2){
> +    word16 = ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_tcp) ? (buf[i+1] &
> 0xFF) : 0);
> +    sum += word16;
> +  }
> +
> +  /* add the TCP pseudo header which contains the IP source and
> destination addresses */
> +  for (i = 0; i < 4; i += 2){
> +    word16 =((psrc_addr[i] << 8) & 0xFF00) + (psrc_addr[i+1] & 0xFF);
> +    sum += word16;
> +  }
> +  for (i = 0; i < 4; i += 2){
> +    word16 =((pdest_addr[i] << 8) & 0xFF00) + (pdest_addr[i+1] & 0xFF);
> +    sum += word16;
> +  }
> +
> +  /* the protocol number and the length of the TCP packet */
> +  sum += (uint16_t) OPENVPN_IPPROTO_TCP + (uint16_t) len_tcp;
> +
> +  /* keep only the last 16 bits of the 32 bit calculated sum and add the
> carries */
> +  while (sum >> 16)
> +    sum = (sum & 0xFFFF) + (sum >> 16);
> +
> +  /* Take the one's complement of sum */
> +  return ((uint16_t) ~sum);
> +}
> +
> +static uint16_t
> +ip_checksum(const void *buf, uint16_t hdr_len) {
> +  unsigned long sum = 0;
> +  const uint16_t *ip1;
> +
> +  ip1 = buf;
> +  while (hdr_len > 1) {
> +    sum += *ip1++;
> +    if (sum & 0x80000000)
> +      sum = (sum & 0xFFFF) + (sum >> 16);
> +    hdr_len -= 2;
> +  }
> +
> +  while (sum >> 16)
> +    sum = (sum & 0xFFFF) + (sum >> 16);
> +
> +  return(~sum);
> +}
> +
> +static int
> +client_nat_ftp_transform(struct buffer *ipbuf,
> +          const int direction, const uint32_t from_address, uint32_t
> replace_address) {
> +
> +  uint32_t array[6] = {0};
> +  int ret = 0;
> +  int data_len = 0;
> +
> +  struct ip_tcp_udp_hdr *hdr = (struct ip_tcp_udp_hdr *) BPTR (ipbuf);
> +
> +  if (hdr->ip.protocol != OPENVPN_IPPROTO_TCP)
> +    return ret;
> +
> +  if (table == NULL)
> +      table = init_delta_table();
> +
> +  delta_table_entry_t *entry = NULL;
> +  delta_table_key_t delta_key;
> +
> +  // Because the address already was NATed, probably on OpenVPN Server
> +  if (direction == CN_OUTGOING)
> +    delta_key.src_addr = from_address;
> +  else if (direction == CN_INCOMING)
> +    delta_key.src_addr = hdr->ip.saddr;
> +
> +  delta_key.src_port = hdr->u.tcp.source;
> +  delta_key.dest_addr = hdr->ip.daddr;
> +  delta_key.dest_port = hdr->u.tcp.dest;
> +
> +#if DEBUG_DELTA
> +  msg (M_INFO, "delta_key - saddr: %d, sport: %d, daddr: %d, dport: %d",
> +  delta_key.src_addr, delta_key.src_port, delta_key.dest_addr,
> delta_key.dest_port);
> +
> +  msg (M_INFO, "seq: %x, ack: %x",
> +  hdr->u.tcp.seq, hdr->u.tcp.ack_seq);
> +#endif
> +
> +  int tcp_data_offset = OPENVPN_TCPH_GET_DOFF (hdr->u.tcp.doff_res);
> +
> +  struct buffer tcpbuf = *ipbuf;
> +  if (!buf_advance (&tcpbuf, sizeof(struct openvpn_iphdr) +
> tcp_data_offset))
> +    return ret;
> +
> +  uint8_t * tcp_data = (uint8_t *) BPTR (&tcpbuf);
> +
> +#if DEBUG_DELTA
> +  msg (M_INFO, "TCP DATA BEFORE NAT:");
> +  hexdump(tcp_data, BLEN(&tcpbuf));
> +#endif
> +
> +  u_int32_t matchlen, matchoff;
> +  int found_pattern = -1;
> +  int i = 0;
> +
> +  for (i = 0; i < sizeof(search) / sizeof(search[0]); i++) {
> +    if (search[i].direction != direction) continue;
> +
> +    found_pattern = find_pattern(tcp_data, BLEN(&tcpbuf),
> +             search[i].pattern,
> +             search[i].plen,
> +             search[i].skip,
> +             search[i].term,
> +             &matchoff, &matchlen,
> +             array,
> +             search[i].getnum);
> +    if (found_pattern) break;
> +  }
> +
> +  if (found_pattern > 0)
> +    {
> +
> +      if (check_debug_level (D_CLIENT_NAT))
> +        {
> +          msg (M_INFO, "client-nat FTP match: %.*s - data: %.*s\n",
> +            matchoff, tcp_data, matchlen, &tcp_data[matchoff]);
> +        }
> +
> +      data_len = BLEN(&tcpbuf) - matchoff;
> +
> +      uint32_t ip = htonl((array[0] << 24) | (array[1] << 16)
> +        | (array[2] << 8) | array[3]);
> +      uint16_t port = htons(array[4] << 8 | array[5]);
> +      uint8_t * addr_tmp = (uint8_t *) &replace_address;
> +
> +      uint8_t new_tcp_data[32];
> +      memset(&new_tcp_data[0], 0, sizeof(new_tcp_data));
> +
> +      int new_len = sprintf((char *) &new_tcp_data[0],
> "%d,%d,%d,%d,%d,%d%.*s",
> +        addr_tmp[0], addr_tmp[1], addr_tmp[2], addr_tmp[3], array[4],
> array[5],
> +        data_len - matchlen, (char *)&tcp_data[matchoff + matchlen]);
> +
> +      if (check_debug_level (D_CLIENT_NAT))
> +        {
> +          msg (M_INFO, "client-nat replaced address from: %.*s to:
> %.*s\n",
> +            data_len, &tcp_data[matchoff], new_len, &new_tcp_data[0]);
> +        }
> +
> +      //If the new len is greater than the old, there will be there an
> adjustment
> +      if (new_len > data_len)
> +        {
> +          //If the entry already exists
> +          if (entry = get_delta_entry(table, delta_key))
> +            {
> +              if (direction == CN_OUTGOING)
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
> (entry->delta_out));       // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
> entry->delta_in);
> +                  entry->delta_out += new_len - data_len;
> +                }
> +              else
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
> (entry->delta_in));        // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
> entry->delta_out);
> +                  entry->delta_in += new_len - data_len;
> +                }
> +              //Update timestamp entry on delta entry, to keep this delta
> alive
> +              entry->timestamp = get_timestamp();
> +            }
> +          else
> +            {
> +              // No entry found. Add a new one.
> +              entry = malloc(sizeof(delta_table_entry_t));
> +              entry->key = delta_key;
> +
> +              if (direction == CN_OUTGOING)
> +                {
> +                  entry->delta_out = new_len - data_len;
> +                  entry->delta_in = 0;
> +                }
> +              else
> +                {
> +                  entry->delta_in = new_len - data_len;
> +                  entry->delta_out = 0;
> +                }
> +              entry->marked_to_remove = 0;
> +              entry->timestamp = get_timestamp();
> +
> +              //Add it to delta table
> +              add_delta_entry(table, entry);
> +            }
> +
> +#if DEBUG_DELTA
> +          print_delta_table_entries(table);
> +#endif
> +
> +          //Increase the tcpbuf and ipbuf reflecting the delta chars
> added to the segment.
> +          ASSERT(buf_inc_len(&tcpbuf, new_len - data_len));
> +          ASSERT(buf_inc_len(ipbuf, new_len - data_len));
> +
> +          //Update tot_len
> +          hdr->ip.tot_len = htons(ntohs(hdr->ip.tot_len) + (new_len -
> data_len));
> +
> +          // Readjust IP Checksum
> +          uint16_t head_len = OPENVPN_IPH_GET_LEN(hdr->ip.version_len);
> +          hdr->ip.check = 0;
> +          uint16_t check = ip_checksum( BPTR (ipbuf), head_len);
> +          hdr->ip.check = check;
> +
> +          //Use new_len here!
> +          memcpy(&tcp_data[matchoff], new_tcp_data, new_len);
> +        }
> +      else
> +        {
> +          // The replace size is the lesser or iqual the original? Pad
> with 0 if necessary.
> +          memcpy(&tcp_data[matchoff], new_tcp_data, data_len);
> +
> +          //If the entry already exists
> +          if (entry = get_delta_entry(table, delta_key))
> +            {
> +              if (direction == CN_OUTGOING)
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
> (entry->delta_out));       // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
> entry->delta_in);
> +                }
> +              else
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
> (entry->delta_in));        // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
> entry->delta_out);
> +                }
> +              //Update timestamp entry on delta entry, to keep this delta
> alive
> +              entry->timestamp = get_timestamp();
> +            }
> +
> +        }
> +
> +      //Update TCP checksum
> +      hdr->u.tcp.check = 0;
> +
> +      uint16_t tot_len = ntohs(hdr->ip.tot_len);
> +      uint16_t head_len = OPENVPN_IPH_GET_LEN(hdr->ip.version_len);
> +
> +      uint16_t check = tcp_checksum(BPTR (ipbuf) + head_len,
> +      tot_len - head_len, hdr->ip.saddr, hdr->ip.daddr);
> +
> +      hdr->u.tcp.check = htons(check);
> +      ret = 1;
> +    }
> +  else
> +    {
> +      //No pattern found. Check if there is a delta entry for this
> connection
> +      if(entry = get_delta_entry(table, delta_key))
> +        {
> +          if (direction == CN_OUTGOING)
> +            {
> +              hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
> entry->delta_out);
> +              hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
> entry->delta_in);
> +            }
> +          else
> +            {
> +              hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) +
> entry->delta_in);
> +              hdr->u.tcp.ack_seq = htonl(ntohl(hdr->u.tcp.ack_seq) -
> entry->delta_out);
> +            }
> +
> +          //Update TCP checksum
> +          hdr->u.tcp.check = 0;
> +
> +          uint16_t tot_len = ntohs(hdr->ip.tot_len);
> +          uint16_t head_len = OPENVPN_IPH_GET_LEN(hdr->ip.version_len);
> +
> +          uint16_t check = tcp_checksum(BPTR (ipbuf) + head_len,
> +          tot_len - head_len, hdr->ip.saddr, hdr->ip.daddr);
> +
> +          hdr->u.tcp.check = htons(check);
> +
> +          //Update timestamp entry on delta entry
> +          entry->timestamp = get_timestamp();
> +
> +          // If it is a FIN package, then remove entry from delta table
> +          if (OPENVPN_TCPH_FIN_MASK & hdr->u.tcp.flags)
> +            {
> +              entry->marked_to_remove = 1;
> +              msg (M_INFO, "Delta marked to be removed!");
> +            }
> +
> +          ret = 1;
> +        }
> +      else
> +        {
> +#if DEBUG_DELTA
> +          // Regular package!
> +          msg (M_INFO, "Regular package!: tot_len %d, seq %x, ack %x\n",
> ntohs(hdr->ip.tot_len), ntohl(hdr->u.tcp.seq), ntohl(hdr->u.tcp.ack_seq));
> +#endif
> +        }
> +    }
> +
> +#if DEBUG_DELTA
> +  msg (M_INFO, "TCP DATA AFTER NAT:");
> +  hexdump(tcp_data, BLEN(&tcpbuf));
> +#endif
> +
> +  return ret;
> +}
> +
>  void
>  client_nat_transform (const struct client_nat_option_list *list,
> -      struct buffer *ipbuf,
> -      const int direction)
> +          struct buffer *ipbuf,
> +          const int direction,
> +          const bool enable_nat_ftp_support)
>  {
>    struct ip_tcp_udp_hdr *h = (struct ip_tcp_udp_hdr *) BPTR (ipbuf);
>    int i;
> -  uint32_t addr, *addr_ptr;
> +  uint32_t addr, *addr_ptr, from_addr;
>    const uint32_t *from, *to;
>    int accumulate = 0;
>    unsigned int amask;
>    unsigned int alog = 0;
>
> +  uint32_t orig_saddr = h->ip.saddr;
> +  uint32_t orig_daddr = h->ip.daddr;
> +
>    if (check_debug_level (D_CLIENT_NAT))
>      print_pkt (&h->ip, "BEFORE", direction, D_CLIENT_NAT);
>
> @@ -212,65 +879,81 @@ client_nat_transform (const struct
> client_nat_option_list *list,
>      {
>        const struct client_nat_entry *e = &list->entries[i]; /* current
> NAT rule */
>        if (e->type ^ direction)
> - {
> -  addr = *(addr_ptr = &h->ip.daddr);
> -  amask = 2;
> - }
> +        {
> +          addr = *(addr_ptr = &h->ip.daddr);
> +          amask = 2;
> +        }
>        else
> - {
> -  addr = *(addr_ptr = &h->ip.saddr);
> -  amask = 1;
> - }
> +        {
> +          addr = *(addr_ptr = &h->ip.saddr);
> +          amask = 1;
> +        }
>        if (direction)
> - {
> -  from = &e->foreign_network;
> -  to = &e->network;
> - }
> +        {
> +          from = &e->foreign_network;
> +          to = &e->network;
> +        }
>        else
> - {
> -  from = &e->network;
> -  to = &e->foreign_network;
> - }
> +        {
> +          from = &e->network;
> +          to = &e->foreign_network;
> +        }
>
>        if (((addr & e->netmask) == *from) && !(amask & alog))
> - {
> -  /* pre-adjust IP checksum */
> -  ADD_CHECKSUM_32(accumulate, addr);
> +        {
> +          from_addr = *from;
> +
> +          /* pre-adjust IP checksum */
> +          ADD_CHECKSUM_32(accumulate, addr);
>
> -  /* do NAT transform */
> -  addr = (addr & ~e->netmask) | *to;
> +          /* do NAT transform */
> +          addr = (addr & ~e->netmask) | *to;
>
> -  /* post-adjust IP checksum */
> -  SUB_CHECKSUM_32(accumulate, addr);
> +          /* post-adjust IP checksum */
> +          SUB_CHECKSUM_32(accumulate, addr);
>
> -  /* write the modified address to packet */
> -  *addr_ptr = addr;
> +          /* write the modified address to packet */
> +          *addr_ptr = addr;
>
> -  /* mark as modified */
> -  alog |= amask;
> - }
> +          /* mark as modified */
> +          alog |= amask;
> +        }
>      }
>    if (alog)
>      {
>        if (check_debug_level (D_CLIENT_NAT))
> - print_pkt (&h->ip, "AFTER", direction, D_CLIENT_NAT);
> +        print_pkt (&h->ip, "AFTER", direction, D_CLIENT_NAT);
>
>        ADJUST_CHECKSUM(accumulate, h->ip.check);
>
>        if (h->ip.protocol == OPENVPN_IPPROTO_TCP)
> - {
> -  if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
> openvpn_tcphdr))
> -    {
> -      ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
> -    }
> - }
> +        {
> +          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
> openvpn_tcphdr))
> +            {
> +              ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
> +            }
> +
> +          uint32_t repl_addr = addr;
> +
> +          if (amask == 2)
> +            {
> +              if (direction)
> +                repl_addr = orig_saddr;
> +              else
> +                repl_addr = orig_daddr;
> +            }
> +
> +          if (enable_nat_ftp_support)
> +            client_nat_ftp_transform(ipbuf, direction, from_addr,
> repl_addr);
> +
> +        }
>        else if (h->ip.protocol == OPENVPN_IPPROTO_UDP)
> - {
> -  if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
> openvpn_udphdr))
> -    {
> -      ADJUST_CHECKSUM(accumulate, h->u.udp.check);
> -    }
> - }
> +        {
> +          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct
> openvpn_udphdr))
> +           {
> +              ADJUST_CHECKSUM(accumulate, h->u.udp.check);
> +            }
> +        }
>      }
>  }
>
> @@ -297,7 +980,7 @@ update_localhost_nat(struct client_nat_option_list
> *dest, in_addr_t local_ip)
>            addr.s_addr = nat_entry->network;
>            char *dot_ip = inet_ntoa(addr);
>
> -          msg (M_INFO, "Updating NAT table from localhost to: %s",
> dot_ip);
> +          msg (M_INFO, "CNAT - Updating NAT table from localhost to: %s",
> dot_ip);
>            ret = true;
>          }
>      }
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> index ce995d9..a58da5d 100755
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -52,15 +52,16 @@ void copy_client_nat_option_list (struct
> client_nat_option_list *dest, const str
>  void print_client_nat_list(const struct client_nat_option_list *list, int
> msglevel);
>
>  void add_client_nat_to_option_list (struct client_nat_option_list *dest,
> -    const char *type,
> -    const char *network,
> -    const char *netmask,
> -    const char *foreign_network,
> -    int msglevel);
> +            const char *type,
> +            const char *network,
> +            const char *netmask,
> +            const char *foreign_network,
> +            int msglevel);
>
>  void client_nat_transform (const struct client_nat_option_list *list,
> -   struct buffer *ipbuf,
> -   const int direction);
> +            struct buffer *ipbuf,
> +            const int direction,
> +            const bool enable_nat_ftp_support);
>
>  bool update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip);
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> old mode 100644
> new mode 100755
> index 217fbb3..615db7a
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -980,9 +980,6 @@ process_incoming_tun (struct context *c)
>
>    perf_push (PERF_PROC_IN_TUN);
>
> -  if (c->c2.buf.len > 0)
> -    c->c2.tun_read_bytes += c->c2.buf.len;
> -
>  #ifdef LOG_RW
>    if (c->c2.log_rw && c->c2.buf.len > 0)
>      fprintf (stderr, "r");
> @@ -999,6 +996,9 @@ process_incoming_tun (struct context *c)
>         */
>        process_ip_header (c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT,
> &c->c2.buf);
>
> +      if (c->c2.buf.len > 0)
> +        c->c2.tun_read_bytes += c->c2.buf.len;
> +
>  #ifdef PACKET_TRUNCATION_CHECK
>        /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
>        ipv4_packet_size_verify (BPTR (&c->c2.buf),
> @@ -1041,43 +1041,44 @@ process_ip_header (struct context *c, unsigned int
> flags, struct buffer *buf)
>  #else
>        if (flags & PIP_MSSFIX)
>  #endif
> - {
> -  struct buffer ipbuf = *buf;
> -  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
> -    {
> -#if PASSTOS_CAPABILITY
> -      /* extract TOS from IP header */
> -      if (flags & PIPV4_PASSTOS)
> - link_socket_extract_tos (c->c2.link_socket, &ipbuf);
> -#endif
> -
> -      /* possibly alter the TCP MSS */
> -      if (flags & PIP_MSSFIX)
> - mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
> (&c->c2.frame)));
> +        {
> +          if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), buf))
> +            {
>
>  #ifdef ENABLE_CLIENT_NAT
> -      /* possibly do NAT on packet */
> -      if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
> - {
> -  const int direction = (flags & PIPV4_OUTGOING) ? CN_INCOMING :
> CN_OUTGOING;
> -  client_nat_transform (c->options.client_nat, &ipbuf, direction);
> - }
> +              /* possibly do NAT on packet */
> +              if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
> +                {
> +                  const int direction = (flags & PIPV4_OUTGOING) ?
> CN_INCOMING : CN_OUTGOING;
> +                  client_nat_transform(c->options.client_nat, buf,
> direction, c->options.enable_nat_ftp_support);
> +                }
>  #endif
> -      /* possibly extract a DHCP router message */
> -      if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
> - {
> -  const in_addr_t dhcp_router = dhcp_extract_router_msg (&ipbuf);
> -  if (dhcp_router)
> -    route_list_add_vpn_gateway (c->c1.route_list, c->c2.es, dhcp_router);
> - }
> -    }
> -  else if (is_ipv6 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
> -    {
> -      /* possibly alter the TCP MSS */
> -      if (flags & PIP_MSSFIX)
> - mss_fixup_ipv6 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
> (&c->c2.frame)));
> -    }
> - }
> +
> +#if PASSTOS_CAPABILITY
> +              /* extract TOS from IP header */
> +              if (flags & PIPV4_PASSTOS)
> +                link_socket_extract_tos (c->c2.link_socket, buf);
> +#endif
> +
> +              /* possibly alter the TCP MSS */
> +              if (flags & PIP_MSSFIX)
> +                mss_fixup_ipv4 (buf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
> (&c->c2.frame)));
> +
> +              /* possibly extract a DHCP router message */
> +              if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
> +                {
> +                  const in_addr_t dhcp_router = dhcp_extract_router_msg
> (buf);
> +                  if (dhcp_router)
> +                    route_list_add_vpn_gateway (c->c1.route_list, c->
> c2.es, dhcp_router);
> +                }
> +            }
> +          else if (is_ipv6 (TUNNEL_TYPE (c->c1.tuntap), buf))
> +            {
> +              /* possibly alter the TCP MSS */
> +              if (flags & PIP_MSSFIX)
> +                mss_fixup_ipv6 (buf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC
> (&c->c2.frame)));
> +            }
> +        }
>      }
>  }
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> old mode 100644
> new mode 100755
> index 007bd8c..73b615a
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -236,6 +236,7 @@ static const char usage_message[] =
>    "                  the default gateway.  Useful when pushing private
> subnets.\n"
>  #ifdef ENABLE_CLIENT_NAT
>    "--client-nat snat|dnat network netmask alias : on client add 1-to-1
> NAT rule.\n"
> +  "--enable-nat-ftp-support : Enable NAT FTP Support, updating the IP
> address on FTP PORT commands or PASV responses\n"
>  #endif
>  #ifdef ENABLE_PUSH_PEER_INFO
>    "--push-peer-info : (client only) push client info to server.\n"
> @@ -789,6 +790,11 @@ init_options (struct options *o, const bool init_gc)
>    o->max_routes = MAX_ROUTES_DEFAULT;
>    o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
>    o->proto_force = -1;
> +
> +#ifdef ENABLE_CLIENT_NAT
> +  o->enable_nat_ftp_support = false;
> +#endif
> +
>  #ifdef ENABLE_OCC
>    o->occ = true;
>  #endif
> @@ -1535,6 +1541,8 @@ show_settings (const struct options *o)
>  #ifdef ENABLE_CLIENT_NAT
>    if (o->client_nat)
>      print_client_nat_list(o->client_nat, D_SHOW_PARMS);
> +
> +  SHOW_BOOL(enable_nat_ftp_support);
>  #endif
>
>  #ifdef ENABLE_MANAGEMENT
> @@ -5287,6 +5295,10 @@ add_option (struct options *options,
>        cnol_check_alloc (options);
>        add_client_nat_to_option_list(options->client_nat, p[1], p[2],
> p[3], p[4], msglevel);
>      }
> +  else if (streq (p[0], "enable_nat_ftp_support"))
> +    {
> +      options->enable_nat_ftp_support = true;
> +    }
>  #endif
>    else if (streq (p[0], "route") && p[1])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> old mode 100644
> new mode 100755
> index af9a47f..2b27368
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -347,6 +347,7 @@ struct options
>    bool allow_pull_fqdn; /* as a client, allow server to push a FQDN for
> certain parameters */
>
>  #ifdef ENABLE_CLIENT_NAT
> +  bool enable_nat_ftp_support;
>    struct client_nat_option_list *client_nat;
>  #endif
>
> --
> 1.7.9.5
>
>
> From 0aa64f57ecf653cd067dbef2b2378bdfc4f9a754 Mon Sep 17 00:00:00 2001
> From: Rafael Gava <rafael.oliveira@...2056...>
> Date: Fri, 14 Aug 2015 16:46:13 -0300
> Subject: [PATCH] Removed debug messages.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
> ---
>  src/openvpn/clinat.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 1d213f5..991ea75 100755
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -833,7 +833,9 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>            if (OPENVPN_TCPH_FIN_MASK & hdr->u.tcp.flags)
>              {
>                entry->marked_to_remove = 1;
> +#if DEBUG_DELTA
>                msg (M_INFO, "Delta marked to be removed!");
> +#endif
>              }
>
>            ret = 1;
> --
> 1.7.9.5
>
>
> From cf7af4e4784c83a64b8c1e12601d33bdc5b14d59 Mon Sep 17 00:00:00 2001
> From: Rafael Gava <rafael.oliveira@...2056...>
> Date: Thu, 20 Aug 2015 08:47:08 -0300
> Subject: [PATCH] Fixed FTP NAT IP address.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
> ---
>  src/openvpn/clinat.c |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 991ea75..ef400de 100755
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -423,7 +423,7 @@ static int try_number(const char *data, size_t dlen,
> uint32_t array[],
>        if (*data == term && i == array_size - 1)
>          return len;
>
> -      msg (M_ERRNO, "CNAT - try_number - Char %u (got %u nums) `%u'
> unexpected\n", len, i, *data);
> +      msg (M_ERRNO, "CNAT - try_number - Char %u (got %u nums) '%u'
> unexpected\n", len, i, *data);
>        return 0;
>      }
>    }
> @@ -433,7 +433,7 @@ static int try_number(const char *data, size_t dlen,
> uint32_t array[],
>    return 0;
>  }
>
> -static int try_rfc959(const char *, size_t, u_int32_t [], char);
> +static int try_rfc959(const char *, size_t, uint32_t [], char);
>
>  static struct ftp_search {
>    int direction;
> @@ -441,7 +441,7 @@ static struct ftp_search {
>    size_t plen;
>    char skip;
>    char term;
> -  int (*getnum)(const char *, size_t, u_int32_t[], char);
> +  int (*getnum)(const char *, size_t, uint32_t[], char);
>  } search[] = {
>    {
>      CN_OUTGOING,
> @@ -458,7 +458,7 @@ static struct ftp_search {
>
>  /* Returns 0, or length of numbers: 192,168,1,1,5,6 */
>  static int
> -try_rfc959(const char *data, size_t dlen, u_int32_t array[6],
> +try_rfc959(const char *data, size_t dlen, uint32_t array[6],
>             char term)
>  {
>    return try_number(data, dlen, array, 6, ',', term);
> @@ -467,9 +467,9 @@ try_rfc959(const char *data, size_t dlen, u_int32_t
> array[6],
>  /* Grab port: number up to delimiter */
>  static int
>  get_port(const char *data, int start, size_t dlen, char delim,
> -        u_int32_t array[2])
> +        uint32_t array[2])
>  {
> -  u_int16_t port = 0;
> +  uint16_t port = 0;
>    int i;
>
>    for (i = start; i < dlen; i++) {
> @@ -496,13 +496,13 @@ find_pattern(const char *data, size_t dlen,
>        char skip, char term,
>        unsigned int *numoff,
>        unsigned int *numlen,
> -      u_int32_t array[6],
> -      int (*getnum)(const char *, size_t, u_int32_t[], char))
> +      uint32_t array[6],
> +      int (*getnum)(const char *, size_t, uint32_t[], char))
>  {
>    size_t i;
>
>    if (check_debug_level (D_CLIENT_NAT))
> -    msg (M_INFO, "CNAT - find_pattern %s: dlen = %u\n", pattern, dlen);
> +    msg (M_INFO, "CNAT - find_pattern %s: dlen = %u\n", pattern,
> (uint32_t) dlen);
>
>    if (dlen == 0)
>      return 0;
> @@ -530,7 +530,7 @@ find_pattern(const char *data, size_t dlen,
>    i++;
>
>    if (check_debug_level (D_CLIENT_NAT))
> -    msg (M_INFO, "CNAT - Skipped up to `%c'!\n", skip);
> +    msg (M_INFO, "CNAT - Skipped up to '%c' (%d)!\n", skip, skip);
>
>    *numoff = i;
>    *numlen = getnum(data + i, dlen - i, array, term);
> @@ -652,7 +652,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>    hexdump(tcp_data, BLEN(&tcpbuf));
>  #endif
>
> -  u_int32_t matchlen, matchoff;
> +  uint32_t matchlen, matchoff;
>    int found_pattern = -1;
>    int i = 0;
>
> @@ -689,7 +689,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>        uint8_t new_tcp_data[32];
>        memset(&new_tcp_data[0], 0, sizeof(new_tcp_data));
>
> -      int new_len = sprintf((char *) &new_tcp_data[0],
> "%d,%d,%d,%d,%d,%d%.*s",
> +      int new_len = sprintf((char *) &new_tcp_data[0],
> "%03d,%03d,%03d,%03d,%03d,%03d%.*s",
>          addr_tmp[0], addr_tmp[1], addr_tmp[2], addr_tmp[3], array[4],
> array[5],
>          data_len - matchlen, (char *)&tcp_data[matchoff + matchlen]);
>
> @@ -700,7 +700,7 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>          }
>
>        //If the new len is greater than the old, there will be there an
> adjustment
> -      if (new_len > data_len)
> +      if (replace_address != ip && new_len > data_len)
>          {
>            //If the entry already exists
>            if (entry = get_delta_entry(table, delta_key))
> @@ -765,8 +765,8 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>          }
>        else
>          {
> -          // The replace size is the lesser or iqual the original? Pad
> with 0 if necessary.
> -          memcpy(&tcp_data[matchoff], new_tcp_data, data_len);
> +          if (replace_address != ip)
> +            memcpy(&tcp_data[matchoff], new_tcp_data, data_len);
>
>            //If the entry already exists
>            if (entry = get_delta_entry(table, delta_key))
> --
> 1.7.9.5
>
>
> From 63b1ddad1628eb1a179c2bf5010b781284d2bc4f Mon Sep 17 00:00:00 2001
> From: Rafael Gava <rafael.oliveira@...2056...>
> Date: Sat, 15 Aug 2015 16:58:45 -0300
> Subject: [PATCH] Fixed options parameter name enable-nat-ftp-support.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
> ---
>  src/openvpn/options.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 73b615a..1a012e4 100755
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5295,7 +5295,7 @@ add_option (struct options *options,
>        cnol_check_alloc (options);
>        add_client_nat_to_option_list(options->client_nat, p[1], p[2],
> p[3], p[4], msglevel);
>      }
> -  else if (streq (p[0], "enable_nat_ftp_support"))
> +  else if (streq (p[0], "enable-nat-ftp-support"))
>      {
>        options->enable_nat_ftp_support = true;
>      }
> --
> 1.7.9.5
>
>
> From 2f5ac96c0c2c5d9d06a11e0b08ae958e09c2e9b5 Mon Sep 17 00:00:00 2001
> From: Rafael Gava <rafael.oliveira@...2056...>
> Date: Mon, 24 Aug 2015 09:15:34 -0300
> Subject: [PATCH] Allows set yes/no option to enable-nat-ftp-support
> feature.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056...>
> ---
>  src/openvpn/options.c |   21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 1a012e4..4d73d87 100755
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -236,7 +236,9 @@ static const char usage_message[] =
>    "                  the default gateway.  Useful when pushing private
> subnets.\n"
>  #ifdef ENABLE_CLIENT_NAT
>    "--client-nat snat|dnat network netmask alias : on client add 1-to-1
> NAT rule.\n"
> -  "--enable-nat-ftp-support : Enable NAT FTP Support, updating the IP
> address on FTP PORT commands or PASV responses\n"
> +  "--enable-nat-ftp-support : Enable NAT FTP Support, replacing the IP
> address on FTP PORT commands or PASV responses?\n"
> +  "                  'no'    -- No, disable this feature.\n"
> +  "                  'yes'   -- Yes, enable this feature (Enabled by
> default on Windows).\n"
>  #endif
>  #ifdef ENABLE_PUSH_PEER_INFO
>    "--push-peer-info : (client only) push client info to server.\n"
> @@ -792,8 +794,12 @@ init_options (struct options *o, const bool init_gc)
>    o->proto_force = -1;
>
>  #ifdef ENABLE_CLIENT_NAT
> +#ifdef WIN32
> +  o->enable_nat_ftp_support = true;
> +#else
>    o->enable_nat_ftp_support = false;
>  #endif
> +#endif
>
>  #ifdef ENABLE_OCC
>    o->occ = true;
> @@ -5297,7 +5303,18 @@ add_option (struct options *options,
>      }
>    else if (streq (p[0], "enable-nat-ftp-support"))
>      {
> -      options->enable_nat_ftp_support = true;
> +      if (p[1])
> +        {
> +          if (streq (p[1], "yes"))
> +            options->enable_nat_ftp_support = true;
> +          else if (streq (p[1], "no"))
> +            options->enable_nat_ftp_support = false;
> +          else
> +            {
> +              msg (msglevel, "bad enable-nat-ftp-support option: %s --
> must be 'yes' or 'no'", p[1]);
> +              goto err;
> +            }
> +        }
>      }
>  #endif
>    else if (streq (p[0], "route") && p[1])
> --
> 1.7.9.5
>
>
>

--047d7bd76c0010b3ec051edcc8b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div><br></div><div>I&#39;m looking forward to h=
earing from you guys a feedback if the patch for the features added to the =
NAT will be accepted or not or if is there anything else that I need to do =
or change in order to have it merged into the code.</div><div><br></div><di=
v>From the previous replies, it seems that a minor change was requested to =
replace the localhost string with client-ip.</div><div><br></div><div>Anyth=
ing else?</div><div><br></div><div>Thanks in advance,</div><div><br></div><=
div>Rafael</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Tue, Aug 25, 2015 at 10:43 PM, Rafael Gava <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gava100@...277..." target=3D"_blank">gava100@...277...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi,=C2=
=A0</div><div><br></div><div>this is my first submission to the list and I =
hope that I&#39;m doing in the right way. :-)</div><div><br></div><div><br>=
</div><div>Well, the features added to Network Address Translator are:</div=
><div><br></div><div>1) Allow the user to use the string &quot;localhost&qu=
ot; on the client-nat network configuration in a way that is not necessary =
to inform the IP address beforehand. Openvpn will set the dynamic received =
IP from DHCP.=C2=A0</div><div>Example:<br></div><div><br></div><div><span s=
tyle=3D"white-space:pre-wrap">	</span>client-nat snat localhost 255.255.255=
.255 172.20.1.15 # replaces the &#39;localhost&#39; string with the DHCP ad=
dress received from openvpn server.</div><div><br></div><div>2) Allow the u=
ser to enable the FTP NAT support through the --enable-nat-ftp-support opti=
on.=C2=A0</div><div>This is useful for systems that don&#39;t have conntrac=
k-tools support, for example on Windows systems. On windows this feature is=
 enabled by default.</div><div><br></div><div><span style=3D"white-space:pr=
e-wrap">	</span>enable-nat-ftp-support (yes | no)</div><div><br></div><div>=
<br></div><div>The following patch was written based on release/2.3 branch.=
</div><div>----------------------------------------------------------------=
----------------------------------------------------------------------</div=
><div><br></div><div><div>From d11957a025dc6c113874e7b04ce4c8e9513c3b02 Mon=
 Sep 17 00:00:00 2001</div><div>From: venturus &lt;venturus@...2055...(none=
)&gt;</div><div>Date: Thu, 13 Aug 2015 08:26:36 -0300</div><div>Subject: [P=
ATCH] Replaces the client-nat network string &#39;localhost&#39; with the</=
div><div>=C2=A0dynamic IP set to the tun/tap interface by the openvpn</div>=
<div>=C2=A0server. Example:</div><div><br></div><div>--client-nat snat loca=
lhost 255.255.255.255 172.20.1.15 # replaces the &#39;localhost&#39; string=
 with the DHCP address received from openvpn server.</div><div><br></div><d=
iv>Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2063...=
..." target=3D"_blank">rafael.oliveira@...2056...</a>&gt;</div><div>---</di=
v><div>=C2=A0src/openvpn/clinat.c | =C2=A0 57 +++++++++++++++++++++++++++++=
+++++++++++++--------</div><div>=C2=A0src/openvpn/clinat.h | =C2=A0 =C2=A02=
 ++</div><div>=C2=A0src/openvpn/init.c =C2=A0 | =C2=A0 =C2=A04 ++++</div><d=
iv>=C2=A03 files changed, 54 insertions(+), 9 deletions(-)</div><div>=C2=A0=
mode change 100644 =3D&gt; 100755 src/openvpn/clinat.c</div><div>=C2=A0mode=
 change 100644 =3D&gt; 100755 src/openvpn/clinat.h</div><div>=C2=A0mode cha=
nge 100644 =3D&gt; 100755 src/openvpn/init.c</div><div><br></div><div>diff =
--git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</div><div>old mode 1006=
44</div><div>new mode 100755</div><div>index af75fc9..2460185</div><div>---=
 a/src/openvpn/clinat.c</div><div>+++ b/src/openvpn/clinat.c</div><div>@@ -=
107,11 +107,11 @@ copy_client_nat_option_list (struct client_nat_option_lis=
t *dest,</div><div>=C2=A0</div><div>=C2=A0void</div><div>=C2=A0add_client_n=
at_to_option_list (struct client_nat_option_list *dest,</div><div>-<span st=
yle=3D"white-space:pre-wrap">			</span> =C2=A0 =C2=A0 =C2=A0const char *typ=
e,</div><div>-<span style=3D"white-space:pre-wrap">			</span> =C2=A0 =C2=A0=
 =C2=A0const char *network,</div><div>-<span style=3D"white-space:pre-wrap"=
>			</span> =C2=A0 =C2=A0 =C2=A0const char *netmask,</div><div>-<span style=
=3D"white-space:pre-wrap">			</span> =C2=A0 =C2=A0 =C2=A0const char *foreig=
n_network,</div><div>-<span style=3D"white-space:pre-wrap">			</span> =C2=
=A0 =C2=A0 =C2=A0int msglevel)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *type,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *netmask,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *foreign_network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int msglevel)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0struct =
client_nat_entry e;</div><div>=C2=A0 =C2=A0bool ok;</div><div>@@ -126,12 +1=
26,19 @@ add_client_nat_to_option_list (struct client_nat_option_list *dest=
,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0return;</div><div>=C2=A0 =C2=A0 =C2=
=A0}</div><div>=C2=A0</div><div>- =C2=A0e.network =3D getaddr(0, network, 0=
, &amp;ok, NULL);</div><div>- =C2=A0if (!ok)</div><div>+ =C2=A0if (network =
&amp;&amp; !strcmp(network, &quot;localhost&quot;))</div><div>=C2=A0 =C2=A0=
 =C2=A0{</div><div>- =C2=A0 =C2=A0 =C2=A0msg(msglevel, &quot;client-nat: ba=
d network: %s&quot;, network);</div><div>- =C2=A0 =C2=A0 =C2=A0return;</div=
><div>+ =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;*** client-nat localhost det=
ected...&quot;);</div><div>+ =C2=A0 =C2=A0 =C2=A0e.network =3D 0xFFFFFFFF;<=
/div><div>+ =C2=A0 =C2=A0} else {</div><div>+ =C2=A0 =C2=A0 =C2=A0e.network=
 =3D getaddr(0, network, 0, &amp;ok, NULL);</div><div>+ =C2=A0 =C2=A0 =C2=
=A0if (!ok)</div><div>+ =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg(msglevel, &quot;client-nat: bad network: %s&quot;, network);<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;</div><div>+ =C2=A0 =C2=A0 =
=C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0</div><div=
>=C2=A0 =C2=A0e.netmask =3D getaddr(0, netmask, 0, &amp;ok, NULL);</div><di=
v>=C2=A0 =C2=A0if (!ok)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>@@ -148,6=
 +155,7 @@ add_client_nat_to_option_list (struct client_nat_option_list *de=
st,</div><div>=C2=A0 =C2=A0add_entry(dest, &amp;e);</div><div>=C2=A0}</div>=
<div>=C2=A0</div><div>+</div><div>=C2=A0#if 0</div><div>=C2=A0static void</=
div><div>=C2=A0print_checksum (struct openvpn_iphdr *iph, const char *prefi=
x)</div><div>@@ -266,4 +274,35 @@ client_nat_transform (const struct client=
_nat_option_list *list,</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0}</=
div><div>=C2=A0</div><div>+/*</div><div>+* Replaces the localhost token wit=
h the IP received from OpenVPN</div><div>+*/</div><div>+bool=C2=A0</div><di=
v>+update_localhost_nat(struct client_nat_option_list *dest, in_addr_t loca=
l_ip)</div><div>+{</div><div>+ =C2=A0int i;</div><div>+ =C2=A0bool ret =3D =
false;</div><div>+</div><div>+ =C2=A0if (!dest)</div><div>+ =C2=A0 =C2=A0re=
turn ret;</div><div>+</div><div>+ =C2=A0for (i=3D0; i &lt;=3D dest-&gt;n; i=
++)=C2=A0</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0struct=
 client_nat_entry *nat_entry =3D &amp;dest-&gt;entries[i];</div><div>+ =C2=
=A0 =C2=A0 =C2=A0if (nat_entry &amp;&amp; nat_entry-&gt;network =3D=3D 0xFF=
FFFFFF)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entr=
y-&gt;network =3D ntohl(local_ip);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0addr.s_addr =3D nat_entry-&gt;network;</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *dot_ip =3D inet_ntoa(addr);</div><div>+</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;Updating NAT table fro=
m localhost to: %s&quot;, dot_ip);=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D true;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><d=
iv>+ =C2=A0 =C2=A0}</div><div>+</div><div>+ =C2=A0return ret;</div><div>+}<=
/div><div>+</div><div>=C2=A0#endif</div><div>diff --git a/src/openvpn/clina=
t.h b/src/openvpn/clinat.h</div><div>old mode 100644</div><div>new mode 100=
755</div><div>index d55a727..ce995d9</div><div>--- a/src/openvpn/clinat.h</=
div><div>+++ b/src/openvpn/clinat.h</div><div>@@ -62,4 +62,6 @@ void client=
_nat_transform (const struct client_nat_option_list *list,</div><div>=C2=A0=
<span style=3D"white-space:pre-wrap">			</span> =C2=A0 struct buffer *ipbuf=
,</div><div>=C2=A0<span style=3D"white-space:pre-wrap">			</span> =C2=A0 co=
nst int direction);</div><div>=C2=A0</div><div>+bool update_localhost_nat(s=
truct client_nat_option_list *dest, in_addr_t local_ip);</div><div>+</div><=
div>=C2=A0#endif</div><div>diff --git a/src/openvpn/init.c b/src/openvpn/in=
it.c</div><div>old mode 100644</div><div>new mode 100755</div><div>index 71=
c91a2..4a63ee8</div><div>--- a/src/openvpn/init.c</div><div>+++ b/src/openv=
pn/init.c</div><div>@@ -1476,6 +1476,10 @@ do_open_tun (struct context *c)<=
/div><div>=C2=A0<span style=3D"white-space:pre-wrap">			</span> =C2=A0 =C2=
=A0 =C2=A0 c-&gt;c1.tuntap-&gt;post_open_mtu,</div><div>=C2=A0<span style=
=3D"white-space:pre-wrap">			</span> =C2=A0 =C2=A0 =C2=A0 SET_MTU_TUN | SET=
_MTU_UPPER_BOUND);</div><div>=C2=A0</div><div>+#ifdef ENABLE_CLIENT_NAT</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0update_localhost_nat(c-&gt;options.client_nat,=
 c-&gt;c1.tuntap-&gt;local);</div><div>+#endif</div><div>+</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0ret =3D true;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0sta=
tic_context =3D c;</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>--=C2=A0</div>=
<div>1.7.9.5</div><div><br></div><div><br></div><div>From 18b1411689df67fea=
feb15630c3519ab2cbd42d4 Mon Sep 17 00:00:00 2001</div><div>From: Rafael Gav=
a &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=3D"_blank">rafae=
l.oliveira@...2056...</a>&gt;</div><div>Date: Fri, 14 Aug 2015 15:27:50 -03=
00</div><div>Subject: [PATCH] Added FTP NAT support. This feature can be en=
abled via</div><div>=C2=A0--enable-nat-ftp-support option.</div><div><br></=
div><div><br></div><div>Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:ra=
fael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a>&=
gt;</div><div>---</div><div>=C2=A0src/openvpn/clinat.c =C2=A0| =C2=A0773 ++=
++++++++++++++++++++++++++++++++++++++++++++---</div><div>=C2=A0src/openvpn=
/clinat.h =C2=A0| =C2=A0 15 +-</div><div>=C2=A0src/openvpn/forward.c | =C2=
=A0 75 ++---</div><div>=C2=A0src/openvpn/options.c | =C2=A0 12 +</div><div>=
=C2=A0src/openvpn/options.h | =C2=A0 =C2=A01 +</div><div>=C2=A05 files chan=
ged, 787 insertions(+), 89 deletions(-)</div><div>=C2=A0mode change 100644 =
=3D&gt; 100755 src/openvpn/forward.c</div><div>=C2=A0mode change 100644 =3D=
&gt; 100755 src/openvpn/options.c</div><div>=C2=A0mode change 100644 =3D&gt=
; 100755 src/openvpn/options.h</div><div><br></div><div>diff --git a/src/op=
envpn/clinat.c b/src/openvpn/clinat.c</div><div>index 2460185..1d213f5 1007=
55</div><div>--- a/src/openvpn/clinat.c</div><div>+++ b/src/openvpn/clinat.=
c</div><div>@@ -36,6 +36,159 @@</div><div>=C2=A0#include &quot;proto.h&quot=
;</div><div>=C2=A0#include &quot;socket.h&quot;</div><div>=C2=A0#include &q=
uot;memdbg.h&quot;</div><div>+#include &lt;stdio.h&gt;</div><div>+#include =
&lt;ctype.h&gt;</div><div>+#include &lt;string.h&gt;</div><div>+</div><div>=
+/* Delta Table Types */</div><div>+</div><div>+typedef struct delta_table_=
key {</div><div>+ =C2=A0uint32_t src_addr;</div><div>+ =C2=A0uint32_t dest_=
addr;</div><div>+ =C2=A0uint16_t src_port;</div><div>+ =C2=A0uint16_t dest_=
port;</div><div>+} delta_table_key_t;</div><div>+</div><div>+typedef struct=
 delta_table_entry {</div><div>+ =C2=A0delta_table_key_t key;</div><div>+ =
=C2=A0uint16_t delta_out;</div><div>+ =C2=A0uint16_t delta_in;</div><div>+ =
=C2=A0uint8_t marked_to_remove;</div><div>+ =C2=A0uint8_t reserved[3];</div=
><div>+ =C2=A0uint32_t timestamp;</div><div>+ =C2=A0struct delta_table_entr=
y *_next;</div><div>+} delta_table_entry_t;</div><div>+</div><div>+typedef =
struct delta_table {</div><div>+ =C2=A0 =C2=A0struct delta_table_entry *hea=
d;</div><div>+} delta_table_t;</div><div>+</div><div>+</div><div>+// Global=
 delta table</div><div>+//#define DEBUG_DELTA 1</div><div>+</div><div>+delt=
a_table_t *table =3D NULL;</div><div>+</div><div>+#define TIME_TO_RESPOND 6=
0 * 5 // 5 Minutes</div><div>+#define TIME_TO_LIVE 24 * 60 * 60</div><div>+=
</div><div>+/* Delta Table Functions */</div><div>+</div><div>+// In second=
s, since epoch</div><div>+static uint32_t=C2=A0</div><div>+get_timestamp() =
{</div><div>+ =C2=A0return (uint32_t)time(NULL);</div><div>+}</div><div>+</=
div><div>+static void=C2=A0</div><div>+print_delta_table_entries(delta_tabl=
e_t *table) {</div><div>+ =C2=A0 =C2=A0delta_table_entry_t *current =3D tab=
le-&gt;head;</div><div>+</div><div>+ =C2=A0if (current =3D=3D NULL) {</div>=
<div>+ =C2=A0 =C2=A0return;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=
=A0while (current !=3D NULL) {</div><div>+ =C2=A0 =C2=A0printf(&quot;from %=
d -&gt; to %d: removed: %s, timestamp: %d, delta_out: %d, delta_in: %d\n&qu=
ot;,=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0current-&gt;key.src_addr, curren=
t-&gt;key.dest_addr, current-&gt;marked_to_remove ? &quot;true&quot; : &quo=
t;false&quot;,=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0current-&gt;timestamp,=
 current-&gt;delta_out, current-&gt;delta_in);</div><div>+ =C2=A0 =C2=A0cur=
rent =3D current-&gt;_next;</div><div>+ =C2=A0}</div><div>+}</div><div>+</d=
iv><div>+static struct delta_table *</div><div>+init_delta_table() {</div><=
div>+ =C2=A0delta_table_t *table =3D malloc(sizeof(delta_table_t));</div><d=
iv>+ =C2=A0table-&gt;head =3D NULL;</div><div>+ =C2=A0return table;</div><d=
iv>+}</div><div>+</div><div>+static struct delta_table_entry *</div><div>+a=
dd_delta_entry(delta_table_t *table, delta_table_entry_t *new_delta_entry) =
{</div><div>+ =C2=A0if (table-&gt;head =3D=3D NULL) {</div><div>+ =C2=A0 =
=C2=A0table-&gt;head =3D new_delta_entry;</div><div>+ =C2=A0 =C2=A0table-&g=
t;head-&gt;_next =3D NULL;</div><div>+ =C2=A0} else {</div><div>+ =C2=A0 =
=C2=A0// Add element to HEAD, for performance gain</div><div>+ =C2=A0 =C2=
=A0new_delta_entry-&gt;_next =3D table-&gt;head;</div><div>+ =C2=A0 =C2=A0t=
able-&gt;head =3D new_delta_entry;=C2=A0</div><div>+ =C2=A0}</div><div>+ =
=C2=A0return new_delta_entry;</div><div>+}</div><div>+</div><div>+static in=
t=C2=A0</div><div>+remove_delta_entry(delta_table_t *table, delta_table_ent=
ry_t *delta_entry) {</div><div>+ =C2=A0delta_table_entry_t *current =3D tab=
le-&gt;head;</div><div>+ =C2=A0delta_table_entry_t *before =3D NULL;</div><=
div>+ =C2=A0uint8_t found =3D 0;</div><div>+</div><div>+ =C2=A0//msg (M_INF=
O, &quot;On remove_delta_entry - entry: %p&quot;, &amp;delta_entry);</div><=
div>+</div><div>+ =C2=A0while (current !=3D NULL) {</div><div>+ =C2=A0 =C2=
=A0if(current =3D=3D delta_entry) {</div><div>+ =C2=A0 =C2=A0 =C2=A0found =
=3D 1;</div><div>+ =C2=A0 =C2=A0 =C2=A0break;</div><div>+ =C2=A0 =C2=A0}</d=
iv><div>+ =C2=A0 =C2=A0before =3D current;</div><div>+ =C2=A0 =C2=A0current=
 =3D current-&gt;_next;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0/=
/Element not found</div><div>+ =C2=A0if (!found) {</div><div>+ =C2=A0 =C2=
=A0return 0;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0if(before=3D=
=3DNULL){</div><div>+ =C2=A0 =C2=A0table-&gt;head =3D table-&gt;head-&gt;_n=
ext;</div><div>+ =C2=A0} else {</div><div>+ =C2=A0 =C2=A0before-&gt;_next =
=3D delta_entry-&gt;_next;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=
=A0//msg (M_INFO, &quot;On remove_delta_entry - entry: %p - freed&quot;, &a=
mp;delta_entry);</div><div>+ =C2=A0</div><div>+ =C2=A0free(delta_entry);</d=
iv><div>+ =C2=A0return 1;</div><div>+}</div><div>+</div><div>+static struct=
 delta_table_entry *</div><div>+get_delta_entry(delta_table_t *table, delta=
_table_key_t key) {</div><div>+ =C2=A0delta_table_entry_t *current =3D tabl=
e-&gt;head;</div><div>+ =C2=A0delta_table_entry_t *aux =3D NULL;</div><div>=
+ =C2=A0delta_table_entry_t *el =3D NULL;</div><div>+</div><div>+ =C2=A0whi=
le (current !=3D NULL) {</div><div>+ =C2=A0 =C2=A0// Check TTL and Timeout<=
/div><div>+ =C2=A0 =C2=A0if ((current-&gt;marked_to_remove &amp;&amp; get_t=
imestamp() - current-&gt;timestamp &gt;=3D TIME_TO_RESPOND) /* || =C2=A0get=
_timestamp() - current-&gt;timestamp &gt;=3D TIME_TO_LIVE */){</div><div>+ =
=C2=A0 =C2=A0 =C2=A0aux =3D current;</div><div>+ =C2=A0 =C2=A0 =C2=A0//If t=
he CURRENT is to be removed, then dont return it</div><div>+ =C2=A0 =C2=A0 =
=C2=A0if (aux =3D=3D el) {=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0el =
=3D NULL;</div><div>+ =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=
=A0current =3D current-&gt;_next;</div><div>+ =C2=A0 =C2=A0 =C2=A0remove_de=
lta_entry(table, aux);</div><div>+ =C2=A0 =C2=A0} else {</div><div>+ =C2=A0=
 =C2=A0 =C2=A0if ((</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0// Regular conne=
ction</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0(current-&gt;key.src_addr =3D=
=3D key.src_addr &amp;&amp;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 current=
-&gt;key.src_port =3D=3D key.src_port &amp;&amp;=C2=A0</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 current-&gt;key.dest_addr =3D=3D key.dest_addr &amp;&a=
mp;=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 current-&gt;key.dest_port=
 =3D=3D key.dest_port) ||</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0//Check if=
 it is a returned connection</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0(curren=
t-&gt;key.dest_addr =3D=3D key.src_addr &amp;&amp;</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 current-&gt;key.dest_port =3D=3D key.src_port &amp;&amp;=
=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 current-&gt;key.src_addr =3D=
=3D key.dest_addr &amp;&amp;=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
current-&gt;key.src_port =3D=3D key.dest_port))) {</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0el =3D current;</div><div>+ =C2=A0 =C2=A0 =C2=A0}=C2=A0</d=
iv><div>+ =C2=A0 =C2=A0 =C2=A0current =3D current-&gt;_next;</div><div>+ =
=C2=A0 =C2=A0}</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0return el;=
</div><div>+}</div><div>+</div><div>+/* Delta Table Functions End */</div><=
div>+</div><div>=C2=A0</div><div>=C2=A0static bool</div><div>=C2=A0add_entr=
y(struct client_nat_option_list *dest,</div><div>@@ -192,19 +345,533 @@ pri=
nt_pkt (struct openvpn_iphdr *iph, const char *prefix, const int direction,=
 c</div><div>=C2=A0 =C2=A0gc_free (&amp;gc);</div><div>=C2=A0}</div><div>=
=C2=A0</div><div>+#if DEBUG_DELTA</div><div>+</div><div>+#ifndef HEXDUMP_CO=
LS</div><div>+#define HEXDUMP_COLS 8</div><div>+#endif</div><div>+</div><di=
v>+static void hexdump(void *mem, unsigned int len)</div><div>+{</div><div>=
+ =C2=A0unsigned int i, j;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><di=
v>+ =C2=A0for(i =3D 0; i &lt; len + ((len % HEXDUMP_COLS) ? (HEXDUMP_COLS -=
 len % HEXDUMP_COLS) : 0); i++)</div><div>+ =C2=A0{</div><div>+ =C2=A0 =C2=
=A0/* print offset */</div><div>+ =C2=A0 =C2=A0if(i % HEXDUMP_COLS =3D=3D 0=
)</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0printf(&quot;0=
x%06x: &quot;, i);</div><div>+ =C2=A0 =C2=A0}</div><div>+=C2=A0</div><div>+=
 =C2=A0 =C2=A0/* print hex data */</div><div>+ =C2=A0 =C2=A0if(i &lt; len)<=
/div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0printf(&quot;%02=
x &quot;, 0xFF &amp; ((char*)mem)[i]);</div><div>+ =C2=A0 =C2=A0}</div><div=
>+ =C2=A0 =C2=A0else /* end of block, just aligning for ASCII dump */</div>=
<div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0printf(&quot; =C2=A0 =
&quot;);</div><div>+ =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>+ =C2=A0 =C2=A0/* print ASCII dump *=
/</div><div>+ =C2=A0 =C2=A0if(i % HEXDUMP_COLS =3D=3D (HEXDUMP_COLS - 1))</=
div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0for(j =3D i - (HE=
XDUMP_COLS - 1); j &lt;=3D i; j++)</div><div>+ =C2=A0 =C2=A0 =C2=A0{</div><=
div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char ch =3D 0xFF &amp; ((char*)me=
m)[j];</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if(j &gt;=3D len)=
 /* end of block, not really printing */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0putchar(&#39; &#39;);=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0else if (ch &gt;=3D 0x80)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0putchar(&#39;.&#3=
9;);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else if(isprint(((char*)mem)[j])) /* printable char */</div><div>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0putchar(0xFF &amp; ((char*)mem)[j]); =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><d=
iv>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0el=
se /* other char */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0putchar(&#39;.&#39;);</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =
=C2=A0 =C2=A0putchar(&#39;\n&#39;);</div><div>+ =C2=A0 =C2=A0}</div><div>+ =
=C2=A0}</div><div>+}</div><div>+#endif</div><div>+</div><div>+static int tr=
y_number(const char *data, size_t dlen, uint32_t array[],</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int array_size, char sep, char term)</div><d=
iv>+{</div><div>+ =C2=A0uint32_t i, len;</div><div>+</div><div>+ =C2=A0mems=
et(array, 0, sizeof(array[0])*array_size);</div><div>+</div><div>+ =C2=A0/*=
 Keep data pointing at next char. */</div><div>+ =C2=A0for (i =3D 0, len =
=3D 0; len &lt; dlen &amp;&amp; i &lt; array_size; len++, data++) {</div><d=
iv>+ =C2=A0 =C2=A0if (*data &gt;=3D &#39;0&#39; &amp;&amp; *data &lt;=3D &#=
39;9&#39;) {</div><div>+ =C2=A0 =C2=A0 =C2=A0array[i] =3D array[i]*10 + *da=
ta - &#39;0&#39;;</div><div>+ =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0else =
if (*data =3D=3D sep)</div><div>+ =C2=A0 =C2=A0 =C2=A0i++;</div><div>+ =C2=
=A0 =C2=A0else {</div><div>+ =C2=A0 =C2=A0 =C2=A0/* Unexpected character; t=
rue if it&#39;s the</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 terminator and =
we&#39;re finished. */</div><div>+ =C2=A0 =C2=A0 =C2=A0if (*data =3D=3D ter=
m &amp;&amp; i =3D=3D array_size - 1)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return len;</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0msg (M_ERRNO, &q=
uot;CNAT - try_number - Char %u (got %u nums) `%u&#39; unexpected\n&quot;, =
len, i, *data);</div><div>+ =C2=A0 =C2=A0 =C2=A0return 0;</div><div>+ =C2=
=A0 =C2=A0}</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0msg (M_ERRNO,=
 &quot;CNAT - ERROR: Failed to fill %u numbers separated by %c\n&quot;, arr=
ay_size, sep);</div><div>+</div><div>+ =C2=A0return 0;</div><div>+}</div><d=
iv>+</div><div>+static int try_rfc959(const char *, size_t, u_int32_t [], c=
har);</div><div>+</div><div>+static struct ftp_search {</div><div>+ =C2=A0i=
nt direction;</div><div>+ =C2=A0const char *pattern;</div><div>+ =C2=A0size=
_t plen;</div><div>+ =C2=A0char skip;</div><div>+ =C2=A0char term;</div><di=
v>+ =C2=A0int (*getnum)(const char *, size_t, u_int32_t[], char);</div><div=
>+} search[] =3D {</div><div>+ =C2=A0{</div><div>+ =C2=A0 =C2=A0CN_OUTGOING=
,</div><div>+ =C2=A0 =C2=A0&quot;PORT&quot;, =C2=A0sizeof(&quot;PORT&quot;)=
 - 1, &#39; &#39;, &#39;\r&#39;,</div><div>+ =C2=A0 =C2=A0try_rfc959,</div>=
<div>+ =C2=A0},</div><div>+ =C2=A0{</div><div>+ =C2=A0 =C2=A0CN_INCOMING,</=
div><div>+ =C2=A0 =C2=A0&quot;227 &quot;, =C2=A0sizeof(&quot;227 &quot;) - =
1, &#39;(&#39;, &#39;)&#39;,</div><div>+ =C2=A0 =C2=A0try_rfc959,</div><div=
>+ =C2=A0},</div><div>+};</div><div>+</div><div>+</div><div>+/* Returns 0, =
or length of numbers: 192,168,1,1,5,6 */</div><div>+static int=C2=A0</div><=
div>+try_rfc959(const char *data, size_t dlen, u_int32_t array[6],</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char term)</div><div>+{</div><div>+ =
=C2=A0return try_number(data, dlen, array, 6, &#39;,&#39;, term);</div><div=
>+}</div><div>+</div><div>+/* Grab port: number up to delimiter */</div><di=
v>+static int=C2=A0</div><div>+get_port(const char *data, int start, size_t=
 dlen, char delim,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0u_int32_t array[2=
])</div><div>+{</div><div>+ =C2=A0u_int16_t port =3D 0;</div><div>+ =C2=A0i=
nt i;</div><div>+</div><div>+ =C2=A0for (i =3D start; i &lt; dlen; i++) {</=
div><div>+ =C2=A0 =C2=A0/* Finished? */</div><div>+ =C2=A0 =C2=A0if (data[i=
] =3D=3D delim) {</div><div>+ =C2=A0 =C2=A0 =C2=A0if (port =3D=3D 0)</div><=
div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+ =C2=A0 =C2=A0 =C2=A0arr=
ay[0] =3D port &gt;&gt; 8;</div><div>+ =C2=A0 =C2=A0 =C2=A0array[1] =3D por=
t;</div><div>+ =C2=A0 =C2=A0 =C2=A0return i + 1;</div><div>+ =C2=A0 =C2=A0}=
</div><div>+ =C2=A0 =C2=A0else if (data[i] &gt;=3D &#39;0&#39; &amp;&amp; d=
ata[i] &lt;=3D &#39;9&#39;)</div><div>+ =C2=A0 =C2=A0 =C2=A0port =3D port*1=
0 + data[i] - &#39;0&#39;;</div><div>+ =C2=A0 =C2=A0else /* Some other crap=
 */</div><div>+ =C2=A0 =C2=A0 =C2=A0break;</div><div>+ =C2=A0}</div><div>+ =
=C2=A0return 0;</div><div>+}</div><div>+</div><div>+/* Return 1 for match, =
0 for accept, -1 for partial. */</div><div>+static int=C2=A0</div><div>+fin=
d_pattern(const char *data, size_t dlen,</div><div>+ =C2=A0 =C2=A0 =C2=A0co=
nst char *pattern, size_t plen,</div><div>+ =C2=A0 =C2=A0 =C2=A0char skip, =
char term,</div><div>+ =C2=A0 =C2=A0 =C2=A0unsigned int *numoff,</div><div>=
+ =C2=A0 =C2=A0 =C2=A0unsigned int *numlen,</div><div>+ =C2=A0 =C2=A0 =C2=
=A0u_int32_t array[6],</div><div>+ =C2=A0 =C2=A0 =C2=A0int (*getnum)(const =
char *, size_t, u_int32_t[], char))</div><div>+{</div><div>+ =C2=A0size_t i=
;</div><div>+</div><div>+ =C2=A0if (check_debug_level (D_CLIENT_NAT))</div>=
<div>+ =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - find_pattern %s: dlen =3D %u\=
n&quot;, pattern, dlen);</div><div>+</div><div>+ =C2=A0if (dlen =3D=3D 0)</=
div><div>+ =C2=A0 =C2=A0return 0;</div><div>+</div><div>+ =C2=A0if (dlen &l=
t;=3D plen) {</div><div>+ =C2=A0 =C2=A0/* Short packet: try for partial? */=
</div><div>+ =C2=A0 =C2=A0if (strncasecmp(data, pattern, dlen) =3D=3D 0)</d=
iv><div>+ =C2=A0 =C2=A0 =C2=A0return -1;</div><div>+ =C2=A0 =C2=A0else retu=
rn 0;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0if (strncasecmp(dat=
a, pattern, plen) !=3D 0) {</div><div>+ =C2=A0 =C2=A0return 0;</div><div>+ =
=C2=A0}</div><div>+</div><div>+ =C2=A0if (check_debug_level (D_CLIENT_NAT))=
</div><div>+ =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Pattern matches!\n&quot=
;);</div><div>+</div><div>+ =C2=A0/* Now we&#39;ve found the constant strin=
g, try to skip</div><div>+ =C2=A0 =C2=A0 to the &#39;skip&#39; character */=
</div><div>+ =C2=A0for (i =3D plen; data[i] !=3D skip; i++)</div><div>+ =C2=
=A0 =C2=A0if (i =3D=3D dlen - 1) return -1;</div><div>+</div><div>+ =C2=A0/=
* Skip over the last character */</div><div>+ =C2=A0i++;</div><div>+</div><=
div>+ =C2=A0if (check_debug_level (D_CLIENT_NAT))</div><div>+ =C2=A0 =C2=A0=
msg (M_INFO, &quot;CNAT - Skipped up to `%c&#39;!\n&quot;, skip);</div><div=
>+</div><div>+ =C2=A0*numoff =3D i;</div><div>+ =C2=A0*numlen =3D getnum(da=
ta + i, dlen - i, array, term);</div><div>+ =C2=A0if (!*numlen)</div><div>+=
 =C2=A0 =C2=A0return -1;</div><div>+</div><div>+ =C2=A0if (check_debug_leve=
l (D_CLIENT_NAT))</div><div>+ =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Match =
succeeded!\n&quot;);</div><div>+ =C2=A0</div><div>+ =C2=A0return 1;</div><d=
iv>+}</div><div>+</div><div>+static uint16_t</div><div>+tcp_checksum (const=
 uint8_t *buf,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const int len_tcp,</d=
iv><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t src_addr,</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t dest_addr)</div><div>+{</div><div=
>+ =C2=A0uint16_t word16;</div><div>+ =C2=A0uint32_t sum =3D 0;</div><div>+=
 =C2=A0int i;</div><div>+ =C2=A0uint8_t * psrc_addr =3D (uint8_t *) &amp;sr=
c_addr;</div><div>+ =C2=A0uint8_t * pdest_addr =3D (uint8_t *) &amp;dest_ad=
dr;</div><div>+ =C2=A0</div><div>+ =C2=A0/* make 16 bit words out of every =
two adjacent 8 bit words and =C2=A0*/</div><div>+ =C2=A0/* calculate the su=
m of all 16 bit words */</div><div>+ =C2=A0for (i =3D 0; i &lt; len_tcp; i =
+=3D 2){</div><div>+ =C2=A0 =C2=A0word16 =3D ((buf[i] &lt;&lt; 8) &amp; 0xF=
F00) + ((i + 1 &lt; len_tcp) ? (buf[i+1] &amp; 0xFF) : 0);</div><div>+ =C2=
=A0 =C2=A0sum +=3D word16;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=
=A0/* add the TCP pseudo header which contains the IP source and destinatio=
n addresses */</div><div>+ =C2=A0for (i =3D 0; i &lt; 4; i +=3D 2){</div><d=
iv>+ =C2=A0 =C2=A0word16 =3D((psrc_addr[i] &lt;&lt; 8) &amp; 0xFF00) + (psr=
c_addr[i+1] &amp; 0xFF);</div><div>+ =C2=A0 =C2=A0sum +=3D word16;</div><di=
v>+ =C2=A0}</div><div>+ =C2=A0for (i =3D 0; i &lt; 4; i +=3D 2){</div><div>=
+ =C2=A0 =C2=A0word16 =3D((pdest_addr[i] &lt;&lt; 8) &amp; 0xFF00) + (pdest=
_addr[i+1] &amp; 0xFF);</div><div>+ =C2=A0 =C2=A0sum +=3D word16; =C2=A0=C2=
=A0</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0/* the protocol numbe=
r and the length of the TCP packet */</div><div>+ =C2=A0sum +=3D (uint16_t)=
 OPENVPN_IPPROTO_TCP + (uint16_t) len_tcp;</div><div>+</div><div>+ =C2=A0/*=
 keep only the last 16 bits of the 32 bit calculated sum and add the carrie=
s */</div><div>+ =C2=A0while (sum &gt;&gt; 16)</div><div>+ =C2=A0 =C2=A0sum=
 =3D (sum &amp; 0xFFFF) + (sum &gt;&gt; 16);</div><div>+ =C2=A0 =C2=A0</div=
><div>+ =C2=A0/* Take the one&#39;s complement of sum */</div><div>+ =C2=A0=
return ((uint16_t) ~sum);</div><div>+}</div><div>+</div><div>+static uint16=
_t=C2=A0</div><div>+ip_checksum(const void *buf, uint16_t hdr_len) {</div><=
div>+ =C2=A0unsigned long sum =3D 0;</div><div>+ =C2=A0const uint16_t *ip1;=
</div><div>+</div><div>+ =C2=A0ip1 =3D buf;</div><div>+ =C2=A0while (hdr_le=
n &gt; 1) {</div><div>+ =C2=A0 =C2=A0sum +=3D *ip1++;</div><div>+ =C2=A0 =
=C2=A0if (sum &amp; 0x80000000)</div><div>+ =C2=A0 =C2=A0 =C2=A0sum =3D (su=
m &amp; 0xFFFF) + (sum &gt;&gt; 16);</div><div>+ =C2=A0 =C2=A0hdr_len -=3D =
2;</div><div>+ =C2=A0}</div><div>+</div><div>+ =C2=A0while (sum &gt;&gt; 16=
)</div><div>+ =C2=A0 =C2=A0sum =3D (sum &amp; 0xFFFF) + (sum &gt;&gt; 16);<=
/div><div>+</div><div>+ =C2=A0return(~sum);</div><div>+}</div><div>+</div><=
div>+static int=C2=A0</div><div>+client_nat_ftp_transform(struct buffer *ip=
buf,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int direction, con=
st uint32_t from_address, uint32_t replace_address) {</div><div>+</div><div=
>+ =C2=A0uint32_t array[6] =3D {0};</div><div>+ =C2=A0int ret =3D 0;</div><=
div>+ =C2=A0int data_len =3D 0;</div><div>+</div><div>+ =C2=A0struct ip_tcp=
_udp_hdr *hdr =3D (struct ip_tcp_udp_hdr *) BPTR (ipbuf);</div><div>+</div>=
<div>+ =C2=A0if (hdr-&gt;ip.protocol !=3D OPENVPN_IPPROTO_TCP)</div><div>+ =
=C2=A0 =C2=A0return ret;</div><div>+</div><div>+ =C2=A0if (table =3D=3D NUL=
L)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0table =3D init_delta_table();</div=
><div>+ =C2=A0</div><div>+ =C2=A0delta_table_entry_t *entry =3D NULL;</div>=
<div>+ =C2=A0delta_table_key_t delta_key;</div><div>+</div><div>+ =C2=A0// =
Because the address already was NATed, probably on OpenVPN Server</div><div=
>+ =C2=A0if (direction =3D=3D CN_OUTGOING)</div><div>+ =C2=A0 =C2=A0delta_k=
ey.src_addr =3D from_address;</div><div>+ =C2=A0else if (direction =3D=3D C=
N_INCOMING)</div><div>+ =C2=A0 =C2=A0delta_key.src_addr =3D hdr-&gt;ip.sadd=
r;</div><div>+</div><div>+ =C2=A0delta_key.src_port =3D hdr-&gt;u.tcp.sourc=
e;</div><div>+ =C2=A0delta_key.dest_addr =3D hdr-&gt;ip.daddr;</div><div>+ =
=C2=A0delta_key.dest_port =3D hdr-&gt;u.tcp.dest;</div><div>+</div><div>+#i=
f DEBUG_DELTA</div><div>+ =C2=A0msg (M_INFO, &quot;delta_key - saddr: %d, s=
port: %d, daddr: %d, dport: %d&quot;,=C2=A0</div><div>+ =C2=A0delta_key.src=
_addr, delta_key.src_port, delta_key.dest_addr, delta_key.dest_port);</div>=
<div>+</div><div>+ =C2=A0msg (M_INFO, &quot;seq: %x, ack: %x&quot;,=C2=A0</=
div><div>+ =C2=A0hdr-&gt;u.tcp.seq, hdr-&gt;u.tcp.ack_seq);</div><div>+#end=
if</div><div>+</div><div>+ =C2=A0int tcp_data_offset =3D OPENVPN_TCPH_GET_D=
OFF (hdr-&gt;u.tcp.doff_res);</div><div>+</div><div>+ =C2=A0struct buffer t=
cpbuf =3D *ipbuf;</div><div>+ =C2=A0if (!buf_advance (&amp;tcpbuf, sizeof(s=
truct openvpn_iphdr) + tcp_data_offset))</div><div>+ =C2=A0 =C2=A0return re=
t;</div><div>+</div><div>+ =C2=A0uint8_t * tcp_data =3D (uint8_t *) BPTR (&=
amp;tcpbuf);</div><div>+</div><div>+#if DEBUG_DELTA</div><div>+ =C2=A0msg (=
M_INFO, &quot;TCP DATA BEFORE NAT:&quot;);</div><div>+ =C2=A0hexdump(tcp_da=
ta, BLEN(&amp;tcpbuf)); =C2=A0 =C2=A0</div><div>+#endif</div><div>+</div><d=
iv>+ =C2=A0u_int32_t matchlen, matchoff;</div><div>+ =C2=A0int found_patter=
n =3D -1;</div><div>+ =C2=A0int i =3D 0;</div><div>+</div><div>+ =C2=A0for =
(i =3D 0; i &lt; sizeof(search) / sizeof(search[0]); i++) {</div><div>+ =C2=
=A0 =C2=A0if (search[i].direction !=3D direction) continue;</div><div>+</di=
v><div>+ =C2=A0 =C2=A0found_pattern =3D find_pattern(tcp_data, BLEN(&amp;tc=
pbuf),</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 search[i].patt=
ern,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 search[i].plen,<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 search[i].skip,</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 search[i].term,</div><div>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;matchoff, &amp;matchlen,</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 array,</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 search[i].getnum);</div><div>+ =C2=
=A0 =C2=A0if (found_pattern) break;</div><div>+ =C2=A0}</div><div>+</div><d=
iv>+ =C2=A0if (found_pattern &gt; 0)=C2=A0</div><div>+ =C2=A0 =C2=A0{</div>=
<div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT)=
)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;client-nat FTP match: %.*s - data: %=
.*s\n&quot;,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0matchoff,=
 tcp_data, matchlen, &amp;tcp_data[matchoff]);</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0data_len =3D BLE=
N(&amp;tcpbuf) - matchoff;</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0uint=
32_t ip =3D htonl((array[0] &lt;&lt; 24) | (array[1] &lt;&lt; 16)</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0| (array[2] &lt;&lt; 8) | array[3]);</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0uint16_t port =3D htons(array[4] &lt;&lt; 8 | array=
[5]);</div><div>+ =C2=A0 =C2=A0 =C2=A0uint8_t * addr_tmp =3D (uint8_t *) &a=
mp;replace_address;</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0uint8_t new=
_tcp_data[32];</div><div>+ =C2=A0 =C2=A0 =C2=A0memset(&amp;new_tcp_data[0],=
 0, sizeof(new_tcp_data));</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0int =
new_len =3D sprintf((char *) &amp;new_tcp_data[0], &quot;%d,%d,%d,%d,%d,%d%=
.*s&quot;,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_tmp[0], addr_tmp[1],=
 addr_tmp[2], addr_tmp[3], array[4], array[5],=C2=A0</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data_len - matchlen, (char *)&amp;tcp_data[matchoff + matc=
hlen]);</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0if (check_debug_level (=
D_CLIENT_NAT))=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;client-nat replaced ad=
dress from: %.*s to: %.*s\n&quot;,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0data_len, &amp;tcp_data[matchoff], new_len, &amp;new_tcp_data[=
0]);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+ =C2=
=A0 =C2=A0 =C2=A0//If the new len is greater than the old, there will be th=
ere an adjustment</div><div>+ =C2=A0 =C2=A0 =C2=A0if (new_len &gt; data_len=
)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0//If the entry already exists</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (entry =3D get_delta_entry(table, delta_key))=C2=A0=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (direction =3D=3D CN_OUTGOING)=
=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hdr-&gt;u.tcp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + (entry-&gt;delta_out=
)); =C2=A0 =C2=A0 =C2=A0 // Need to update seq and ack</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.ack_se=
q =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delta_in);</div><div>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;de=
lta_out +=3D new_len - data_len;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0else</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0hdr-&gt;u.tcp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + (entry=
-&gt;delta_in)); =C2=A0 =C2=A0 =C2=A0 =C2=A0// Need to update seq and ack</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hd=
r-&gt;u.tcp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;delt=
a_out);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0entry-&gt;delta_in +=3D new_len - data_len;</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Update timestamp entry on delta entry, =
to keep this delta alive</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0entry-&gt;timestamp =3D get_timestamp();</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0else=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// No entry found.=
 Add a new one.</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0entry =3D malloc(sizeof(delta_table_entry_t));</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;key =3D delta_key;</div><div>+=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (direction =
=3D=3D CN_OUTGOING)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0entry-&gt;delta_out =3D new_len - data_len;</div><div>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;d=
elta_in =3D 0;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><d=
iv>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&g=
t;delta_in =3D new_len - data_len;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;delta_out =3D 0;</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;marked_to_remove =3D 0;=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;time=
stamp =3D get_timestamp();</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Add it to delta table=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_delta_entr=
y(table, entry);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</di=
v><div>+</div><div>+#if DEBUG_DELTA</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0print_delta_table_entries(table);</div><div>+#endif</div><div>+</div=
><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Increase the tcpbuf and ipbuf r=
eflecting the delta chars added to the segment.</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ASSERT(buf_inc_len(&amp;tcpbuf, new_len - data_len));</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(buf_inc_len(ipbuf, new_=
len - data_len));</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0//Update tot_len</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;i=
p.tot_len =3D htons(ntohs(hdr-&gt;ip.tot_len) + (new_len - data_len));</div=
><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Readjust IP Checks=
um</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t head_len =3D OPEN=
VPN_IPH_GET_LEN(hdr-&gt;ip.version_len);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0hdr-&gt;ip.check =3D 0;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t check =3D ip_checksum( BPTR (ipbuf), head_len);</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;ip.check =3D check;</div><div=
>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Use new_len here!</div><=
div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;tcp_data[matchoff], new=
_tcp_data, new_len);=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><d=
iv>+ =C2=A0 =C2=A0 =C2=A0else</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div=
><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// The replace size is the lesser=
 or iqual the original? Pad with 0 if necessary.</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memcpy(&amp;tcp_data[matchoff], new_tcp_data, data_len)=
;=C2=A0</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//If the =
entry already exists</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (entr=
y =3D get_delta_entry(table, delta_key))=C2=A0</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (direction =3D=3D CN_OUTGOING)=C2=A0</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.seq =3D hton=
l(ntohl(hdr-&gt;u.tcp.seq) + (entry-&gt;delta_out)); =C2=A0 =C2=A0 =C2=A0 /=
/ Need to update seq and ack</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.ack_seq =3D htonl(ntohl(hdr-&gt;u=
.tcp.ack_seq) - entry-&gt;delta_in);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0else</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + =
(entry-&gt;delta_in)); =C2=A0 =C2=A0 =C2=A0 =C2=A0// Need to update seq and=
 ack</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0hdr-&gt;u.tcp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-=
&gt;delta_out);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//U=
pdate timestamp entry on delta entry, to keep this delta alive</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;timestamp =3D get=
_timestamp();</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><=
div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+ =C2=
=A0 =C2=A0 =C2=A0//Update TCP checksum</div><div>+ =C2=A0 =C2=A0 =C2=A0hdr-=
&gt;u.tcp.check =3D 0;</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0uint16_t=
 tot_len =3D ntohs(hdr-&gt;ip.tot_len);</div><div>+ =C2=A0 =C2=A0 =C2=A0uin=
t16_t head_len =3D OPENVPN_IPH_GET_LEN(hdr-&gt;ip.version_len);</div><div>+=
</div><div>+ =C2=A0 =C2=A0 =C2=A0uint16_t check =3D tcp_checksum(BPTR (ipbu=
f) + head_len,=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0tot_len - head_len, hd=
r-&gt;ip.saddr, hdr-&gt;ip.daddr);=C2=A0</div><div>+</div><div>+ =C2=A0 =C2=
=A0 =C2=A0hdr-&gt;u.tcp.check =3D htons(check);</div><div>+ =C2=A0 =C2=A0 =
=C2=A0ret =3D 1;</div><div>+ =C2=A0 =C2=A0}</div><div>+ =C2=A0else=C2=A0</d=
iv><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0//No pattern found=
. Check if there is a delta entry for this connection</div><div>+ =C2=A0 =
=C2=A0 =C2=A0if(entry =3D get_delta_entry(table, delta_key))=C2=A0</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (direction =3D=3D CN_OUTGOING)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0hdr-&gt;u.tcp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + entry-&=
gt;delta_out);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hdr-&gt;u.tcp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-&gt;de=
lta_in);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else=C2=A0</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.seq =3D htonl(ntohl(hdr-&gt;u.tcp.seq) + =
entry-&gt;delta_in);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0hdr-&gt;u.tcp.ack_seq =3D htonl(ntohl(hdr-&gt;u.tcp.ack_seq) - entry-=
&gt;delta_out);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div=
><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Update TCP checksum=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.check =3D 0;</=
div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t tot_len =
=3D ntohs(hdr-&gt;ip.tot_len);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint16_t head_len =3D OPENVPN_IPH_GET_LEN(hdr-&gt;ip.version_len);</div>=
<div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t check =3D tcp=
_checksum(BPTR (ipbuf) + head_len,=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tot_len - head_len, hdr-&gt;ip.saddr, hdr-&gt;ip.daddr);=C2=A0=
</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;u.tcp.ch=
eck =3D htons(check);</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//Update timestamp entry on delta entry</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0entry-&gt;timestamp =3D get_timestamp();</div><div>+</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// If it is a FIN package, then re=
move entry from delta table</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (OPENVPN_TCPH_FIN_MASK &amp; hdr-&gt;u.tcp.flags)=C2=A0</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;marked_to_remove =3D 1;</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;Delta ma=
rked to be removed!&quot;);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}</div><div>+ =C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
t =3D 1;=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =
=C2=A0 =C2=A0else=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>=
+#if DEBUG_DELTA</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Regular p=
ackage!</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;Re=
gular package!: tot_len %d, seq %x, ack %x\n&quot;, ntohs(hdr-&gt;ip.tot_le=
n), ntohl(hdr-&gt;u.tcp.seq), ntohl(hdr-&gt;u.tcp.ack_seq));</div><div>+#en=
dif</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0}</di=
v><div>+</div><div>+#if DEBUG_DELTA</div><div>+ =C2=A0msg (M_INFO, &quot;TC=
P DATA AFTER NAT:&quot;);</div><div>+ =C2=A0hexdump(tcp_data, BLEN(&amp;tcp=
buf));</div><div>+#endif</div><div>+</div><div>+ =C2=A0return ret;</div><di=
v>+}</div><div>+</div><div>=C2=A0void</div><div>=C2=A0client_nat_transform =
(const struct client_nat_option_list *list,</div><div>-<span style=3D"white=
-space:pre-wrap">		</span> =C2=A0 =C2=A0 =C2=A0struct buffer *ipbuf,</div><=
div>-<span style=3D"white-space:pre-wrap">		</span> =C2=A0 =C2=A0 =C2=A0con=
st int direction)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct buff=
er *ipbuf,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int directio=
n,=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const bool enable_na=
t_ftp_support)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0struct ip_tcp_udp_h=
dr *h =3D (struct ip_tcp_udp_hdr *) BPTR (ipbuf);</div><div>=C2=A0 =C2=A0in=
t i;</div><div>- =C2=A0uint32_t addr, *addr_ptr;</div><div>+ =C2=A0uint32_t=
 addr, *addr_ptr, from_addr;</div><div>=C2=A0 =C2=A0const uint32_t *from, *=
to;</div><div>=C2=A0 =C2=A0int accumulate =3D 0;</div><div>=C2=A0 =C2=A0uns=
igned int amask;</div><div>=C2=A0 =C2=A0unsigned int alog =3D 0;</div><div>=
=C2=A0</div><div>+ =C2=A0uint32_t orig_saddr =3D h-&gt;ip.saddr;</div><div>=
+ =C2=A0uint32_t orig_daddr =3D h-&gt;ip.daddr;</div><div>+</div><div>=C2=
=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT))</div><div>=C2=A0 =C2=A0 =C2=
=A0print_pkt (&amp;h-&gt;ip, &quot;BEFORE&quot;, direction, D_CLIENT_NAT);<=
/div><div>=C2=A0</div><div>@@ -212,65 +879,81 @@ client_nat_transform (cons=
t struct client_nat_option_list *list,</div><div>=C2=A0 =C2=A0 =C2=A0{</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct client_nat_entry *e =3D &amp;=
list-&gt;entries[i]; /* current NAT rule */</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (e-&gt;type ^ direction)</div><div>-<span style=3D"white-space:pre=
-wrap">	</span>{</div><div>-<span style=3D"white-space:pre-wrap">	</span> =
=C2=A0addr =3D *(addr_ptr =3D &amp;h-&gt;ip.daddr);</div><div>-<span style=
=3D"white-space:pre-wrap">	</span> =C2=A0amask =3D 2;</div><div>-<span styl=
e=3D"white-space:pre-wrap">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D *(addr_ptr =3D =
&amp;h-&gt;ip.daddr);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amask =
=3D 2;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0else</div><div>-<span style=3D"white-space:pre-wrap">	</span>{</d=
iv><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0addr =3D *(add=
r_ptr =3D &amp;h-&gt;ip.saddr);</div><div>-<span style=3D"white-space:pre-w=
rap">	</span> =C2=A0amask =3D 1;</div><div>-<span style=3D"white-space:pre-=
wrap">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D *(addr_ptr =3D &amp;h-&gt;ip.saddr);</=
div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amask =3D 1;</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (directio=
n)</div><div>-<span style=3D"white-space:pre-wrap">	</span>{</div><div>-<sp=
an style=3D"white-space:pre-wrap">	</span> =C2=A0from =3D &amp;e-&gt;foreig=
n_network;</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0t=
o =3D &amp;e-&gt;network;</div><div>-<span style=3D"white-space:pre-wrap">	=
</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0from =3D &amp;e-&gt;foreign_network;</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to =3D &amp;e-&gt;network;</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0else</div><d=
iv>-<span style=3D"white-space:pre-wrap">	</span>{</div><div>-<span style=
=3D"white-space:pre-wrap">	</span> =C2=A0from =3D &amp;e-&gt;network;</div>=
<div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0to =3D &amp;e-&gt=
;foreign_network;</div><div>-<span style=3D"white-space:pre-wrap">	</span>}=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from =3D &amp;e-&gt;network;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0to =3D &amp;e-&gt;foreign_network;</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (((=
addr &amp; e-&gt;netmask) =3D=3D *from) &amp;&amp; !(amask &amp; alog))</di=
v><div>-<span style=3D"white-space:pre-wrap">	</span>{</div><div>-<span sty=
le=3D"white-space:pre-wrap">	</span> =C2=A0/* pre-adjust IP checksum */</di=
v><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0ADD_CHECKSUM_32=
(accumulate, addr);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from_addr =3D *from;</div><div>+ =C2=A0 =
=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* pre-adjust IP check=
sum */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADD_CHECKSUM_32(accumu=
late, addr);</div><div>=C2=A0</div><div>-<span style=3D"white-space:pre-wra=
p">	</span> =C2=A0/* do NAT transform */</div><div>-<span style=3D"white-sp=
ace:pre-wrap">	</span> =C2=A0addr =3D (addr &amp; ~e-&gt;netmask) | *to;</d=
iv><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* do NAT transform */</div><di=
v>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D (addr &amp; ~e-&gt;netmask) =
| *to;</div><div>=C2=A0</div><div>-<span style=3D"white-space:pre-wrap">	</=
span> =C2=A0/* post-adjust IP checksum */</div><div>-<span style=3D"white-s=
pace:pre-wrap">	</span> =C2=A0SUB_CHECKSUM_32(accumulate, addr);</div><div>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* post-adjust IP checksum */</div><div=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUB_CHECKSUM_32(accumulate, addr);</di=
v><div>=C2=A0</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=
=A0/* write the modified address to packet */</div><div>-<span style=3D"whi=
te-space:pre-wrap">	</span> =C2=A0*addr_ptr =3D addr;</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* write the modified address to packet */</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*addr_ptr =3D addr;</div><div>=C2=
=A0</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0/* mark =
as modified */</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=
=A0alog |=3D amask;</div><div>-<span style=3D"white-space:pre-wrap">	</span=
>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mark as modified */</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0alog |=3D amask;</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =
=C2=A0if (alog)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT))</div><div>-<span style=3D"w=
hite-space:pre-wrap">	</span>print_pkt (&amp;h-&gt;ip, &quot;AFTER&quot;, d=
irection, D_CLIENT_NAT);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0print_pkt (=
&amp;h-&gt;ip, &quot;AFTER&quot;, direction, D_CLIENT_NAT);</div><div>=C2=
=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;=
ip.check);</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (h-&gt;=
ip.protocol =3D=3D OPENVPN_IPPROTO_TCP)</div><div>-<span style=3D"white-spa=
ce:pre-wrap">	</span>{</div><div>-<span style=3D"white-space:pre-wrap">	</s=
pan> =C2=A0if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(st=
ruct openvpn_tcphdr))</div><div>-<span style=3D"white-space:pre-wrap">	</sp=
an> =C2=A0 =C2=A0{</div><div>-<span style=3D"white-space:pre-wrap">	</span>=
 =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;u.tcp.check);</div><=
div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0}</div><div=
>-<span style=3D"white-space:pre-wrap">	</span>}</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (BLEN(ipbuf=
) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_tcphdr))</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;u.t=
cp.check);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div=
>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t repl_addr =3D add=
r;</div><div>+ =C2=A0 =C2=A0 =C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (amask =3D=3D 2)=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (direction)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0repl_addr =3D orig_saddr;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0else</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0repl_addr =3D orig_daddr;</div><div>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable_nat_ftp_support)</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client_nat_ftp_transform(ipbuf, direction=
, from_addr, repl_addr);</div><div>+ =C2=A0 =C2=A0</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (h-&gt;ip.p=
rotocol =3D=3D OPENVPN_IPPROTO_UDP)</div><div>-<span style=3D"white-space:p=
re-wrap">	</span>{</div><div>-<span style=3D"white-space:pre-wrap">	</span>=
 =C2=A0if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct=
 openvpn_udphdr))</div><div>-<span style=3D"white-space:pre-wrap">	</span> =
=C2=A0 =C2=A0{</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=
=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;u.udp.check);</div><div>=
-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0}</div><div>-<s=
pan style=3D"white-space:pre-wrap">	</span>}</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (BLEN(ipbuf) &=
gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))</div><=
div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {</div><div>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADJUST_CHECKSUM(accumulate, h-&gt;u.udp.check);=
</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0}</di=
v><div>=C2=A0</div><div>@@ -297,7 +980,7 @@ update_localhost_nat(struct cli=
ent_nat_option_list *dest, in_addr_t local_ip)</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr =3D nat_entry-&gt;network;</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dot_ip =3D inet_ntoa(addr);<=
/div><div>=C2=A0</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO,=
 &quot;Updating NAT table from localhost to: %s&quot;, dot_ip);=C2=A0</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Updating=
 NAT table from localhost to: %s&quot;, dot_ip);=C2=A0</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>diff --git a/src/=
openvpn/clinat.h b/src/openvpn/clinat.h</div><div>index ce995d9..a58da5d 10=
0755</div><div>--- a/src/openvpn/clinat.h</div><div>+++ b/src/openvpn/clina=
t.h</div><div>@@ -52,15 +52,16 @@ void copy_client_nat_option_list (struct =
client_nat_option_list *dest, const str</div><div>=C2=A0void print_client_n=
at_list(const struct client_nat_option_list *list, int msglevel);</div><div=
>=C2=A0</div><div>=C2=A0void add_client_nat_to_option_list (struct client_n=
at_option_list *dest,</div><div>-<span style=3D"white-space:pre-wrap">				<=
/span> =C2=A0 =C2=A0const char *type,</div><div>-<span style=3D"white-space=
:pre-wrap">				</span> =C2=A0 =C2=A0const char *network,</div><div>-<span s=
tyle=3D"white-space:pre-wrap">				</span> =C2=A0 =C2=A0const char *netmask,=
</div><div>-<span style=3D"white-space:pre-wrap">				</span> =C2=A0 =C2=A0c=
onst char *foreign_network,</div><div>-<span style=3D"white-space:pre-wrap"=
>				</span> =C2=A0 =C2=A0int msglevel);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0const char *type,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *network,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *netmask,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *foreign_network,</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int msglevel);</div><div>=C2=A0</div><div>=C2=A0voi=
d client_nat_transform (const struct client_nat_option_list *list,</div><di=
v>-<span style=3D"white-space:pre-wrap">			</span> =C2=A0 struct buffer *ip=
buf,</div><div>-<span style=3D"white-space:pre-wrap">			</span> =C2=A0 cons=
t int direction);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stru=
ct buffer *ipbuf,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cons=
t int direction,</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 bool enable_nat_ftp_support);</div><div>=C2=A0</div><div>=C2=A0bool update=
_localhost_nat(struct client_nat_option_list *dest, in_addr_t local_ip);</d=
iv><div>=C2=A0</div><div>diff --git a/src/openvpn/forward.c b/src/openvpn/f=
orward.c</div><div>old mode 100644</div><div>new mode 100755</div><div>inde=
x 217fbb3..615db7a</div><div>--- a/src/openvpn/forward.c</div><div>+++ b/sr=
c/openvpn/forward.c</div><div>@@ -980,9 +980,6 @@ process_incoming_tun (str=
uct context *c)</div><div>=C2=A0</div><div>=C2=A0 =C2=A0perf_push (PERF_PRO=
C_IN_TUN);</div><div>=C2=A0</div><div>- =C2=A0if (c-&gt;c2.buf.len &gt; 0)<=
/div><div>- =C2=A0 =C2=A0c-&gt;c2.tun_read_bytes +=3D c-&gt;c2.buf.len;</di=
v><div>-</div><div>=C2=A0#ifdef LOG_RW</div><div>=C2=A0 =C2=A0if (c-&gt;c2.=
log_rw &amp;&amp; c-&gt;c2.buf.len &gt; 0)</div><div>=C2=A0 =C2=A0 =C2=A0fp=
rintf (stderr, &quot;r&quot;);</div><div>@@ -999,6 +996,9 @@ process_incomi=
ng_tun (struct context *c)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 */</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0process_ip_header (c, PIPV4_PASSTOS|PIP_MSSFI=
X|PIPV4_CLIENT_NAT, &amp;c-&gt;c2.buf);</div><div>=C2=A0</div><div>+ =C2=A0=
 =C2=A0 =C2=A0if (c-&gt;c2.buf.len &gt; 0)</div><div>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0c-&gt;c2.tun_read_bytes +=3D c-&gt;c2.buf.len;</div><div>+</div><div=
>=C2=A0#ifdef PACKET_TRUNCATION_CHECK</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* if (c-&gt;c2.buf.len &gt; 1) --c-&gt;c2.buf.len; */</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0ipv4_packet_size_verify (BPTR (&amp;c-&gt;c2.buf),</div><d=
iv>@@ -1041,43 +1041,44 @@ process_ip_header (struct context *c, unsigned i=
nt flags, struct buffer *buf)</div><div>=C2=A0#else</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (flags &amp; PIP_MSSFIX)</div><div>=C2=A0#endif</div><div>=
-<span style=3D"white-space:pre-wrap">	</span>{</div><div>-<span style=3D"w=
hite-space:pre-wrap">	</span> =C2=A0struct buffer ipbuf =3D *buf;</div><div=
>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0if (is_ipv4 (TUNNEL_T=
YPE (c-&gt;c1.tuntap), &amp;ipbuf))</div><div>-<span style=3D"white-space:p=
re-wrap">	</span> =C2=A0 =C2=A0{</div><div>-#if PASSTOS_CAPABILITY</div><di=
v>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0 =C2=A0/* ext=
ract TOS from IP header */</div><div>-<span style=3D"white-space:pre-wrap">=
	</span> =C2=A0 =C2=A0 =C2=A0if (flags &amp; PIPV4_PASSTOS)</div><div>-<spa=
n style=3D"white-space:pre-wrap">		</span>link_socket_extract_tos (c-&gt;c2=
.link_socket, &amp;ipbuf);</div><div>-#endif</div><div>-<span style=3D"whit=
e-space:pre-wrap">			</span> =C2=A0</div><div>-<span style=3D"white-space:p=
re-wrap">	</span> =C2=A0 =C2=A0 =C2=A0/* possibly alter the TCP MSS */</div=
><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0 =C2=A0if=
 (flags &amp; PIP_MSSFIX)</div><div>-<span style=3D"white-space:pre-wrap">	=
	</span>mss_fixup_ipv4 (&amp;ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;=
c-&gt;c2.frame)));</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ipv4 (TUNNEL_TYPE (c-&gt;c1.tuntap), =
buf))</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>=C2=
=A0</div><div>=C2=A0#ifdef ENABLE_CLIENT_NAT</div><div>-<span style=3D"whit=
e-space:pre-wrap">	</span> =C2=A0 =C2=A0 =C2=A0/* possibly do NAT on packet=
 */</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0 =
=C2=A0if ((flags &amp; PIPV4_CLIENT_NAT) &amp;&amp; c-&gt;options.client_na=
t)</div><div>-<span style=3D"white-space:pre-wrap">		</span>{</div><div>-<s=
pan style=3D"white-space:pre-wrap">		</span> =C2=A0const int direction =3D =
(flags &amp; PIPV4_OUTGOING) ? CN_INCOMING : CN_OUTGOING;</div><div>-<span =
style=3D"white-space:pre-wrap">		</span> =C2=A0client_nat_transform (c-&gt;=
options.client_nat, &amp;ipbuf, direction);</div><div>-<span style=3D"white=
-space:pre-wrap">		</span>}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* possibly do NAT on packet */</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((flags &amp; PIPV4_CLIENT_NAT) &amp;&amp=
; c-&gt;options.client_nat)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0const int direction =3D (flags &amp; PIPV4_OUTGOING) ?=
 CN_INCOMING : CN_OUTGOING;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0client_nat_transform(c-&gt;options.client_nat, b=
uf, direction, c-&gt;options.enable_nat_ftp_support);</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0#endif</d=
iv><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0 =C2=A0=
/* possibly extract a DHCP router message */</div><div>-<span style=3D"whit=
e-space:pre-wrap">	</span> =C2=A0 =C2=A0 =C2=A0if (flags &amp; PIPV4_EXTRAC=
T_DHCP_ROUTER)</div><div>-<span style=3D"white-space:pre-wrap">		</span>{</=
div><div>-<span style=3D"white-space:pre-wrap">		</span> =C2=A0const in_add=
r_t dhcp_router =3D dhcp_extract_router_msg (&amp;ipbuf);</div><div>-<span =
style=3D"white-space:pre-wrap">		</span> =C2=A0if (dhcp_router)</div><div>-=
<span style=3D"white-space:pre-wrap">		</span> =C2=A0 =C2=A0route_list_add_=
vpn_gateway (c-&gt;c1.route_list, c-&gt;<a href=3D"http://c2.es" target=3D"=
_blank">c2.es</a>, dhcp_router);</div><div>-<span style=3D"white-space:pre-=
wrap">		</span>}</div><div>-<span style=3D"white-space:pre-wrap">	</span> =
=C2=A0 =C2=A0}</div><div>-<span style=3D"white-space:pre-wrap">	</span> =C2=
=A0else if (is_ipv6 (TUNNEL_TYPE (c-&gt;c1.tuntap), &amp;ipbuf))</div><div>=
-<span style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0{</div><div>-<s=
pan style=3D"white-space:pre-wrap">	</span> =C2=A0 =C2=A0 =C2=A0/* possibly=
 alter the TCP MSS */</div><div>-<span style=3D"white-space:pre-wrap">	</sp=
an> =C2=A0 =C2=A0 =C2=A0if (flags &amp; PIP_MSSFIX)</div><div>-<span style=
=3D"white-space:pre-wrap">		</span>mss_fixup_ipv6 (&amp;ipbuf, MTU_TO_MSS (=
TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;c2.frame)));</div><div>-<span style=3D"whi=
te-space:pre-wrap">	</span> =C2=A0 =C2=A0}</div><div>-<span style=3D"white-=
space:pre-wrap">	</span>}</div><div>+</div><div>+#if PASSTOS_CAPABILITY</di=
v><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* extract TOS fro=
m IP header */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (flags &amp; PIPV4_PASSTOS)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0link_socket_extract_tos (c-&gt;c2.link_socket, buf)=
;</div><div>+#endif</div><div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* possibly alter the TCP MSS */</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; PIP_MSSFIX)</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mss_fixup_ipv4 (buf,=
 MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;c2.frame)));</div><div>+</div=
><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* possibly extract=
 a DHCP router message */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (flags &amp; PIPV4_EXTRACT_DHCP_ROUTER)</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const in_addr_t dhcp_route=
r =3D dhcp_extract_router_msg (buf);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dhcp_router)</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0route_list_ad=
d_vpn_gateway (c-&gt;c1.route_list, c-&gt;<a href=3D"http://c2.es" target=
=3D"_blank">c2.es</a>, dhcp_router);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (is_ip=
v6 (TUNNEL_TYPE (c-&gt;c1.tuntap), buf))</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* possibly alter the TCP MSS */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; PIP_MSSFIX)</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mss_fixup_ipv6 (buf, MTU_TO=
_MSS (TUN_MTU_SIZE_DYNAMIC (&amp;c-&gt;c2.frame)));</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}</=
div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0}</div><div>=C2=A0</div><div=
>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</div><div>old m=
ode 100644</div><div>new mode 100755</div><div>index 007bd8c..73b615a</div>=
<div>--- a/src/openvpn/options.c</div><div>+++ b/src/openvpn/options.c</div=
><div>@@ -236,6 +236,7 @@ static const char usage_message[] =3D</div><div>=
=C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0the default gateway.=C2=A0 Useful when pushing private subnets.\n&qu=
ot;</div><div>=C2=A0#ifdef ENABLE_CLIENT_NAT</div><div>=C2=A0 =C2=A0&quot;-=
-client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule=
.\n&quot;</div><div>+ =C2=A0&quot;--enable-nat-ftp-support : Enable NAT FTP=
 Support, updating the IP address on FTP PORT commands or PASV responses\n&=
quot; =C2=A0</div><div>=C2=A0#endif</div><div>=C2=A0#ifdef ENABLE_PUSH_PEER=
_INFO</div><div>=C2=A0 =C2=A0&quot;--push-peer-info : (client only) push cl=
ient info to server.\n&quot;</div><div>@@ -789,6 +790,11 @@ init_options (s=
truct options *o, const bool init_gc)</div><div>=C2=A0 =C2=A0o-&gt;max_rout=
es =3D MAX_ROUTES_DEFAULT;</div><div>=C2=A0 =C2=A0o-&gt;resolve_retry_secon=
ds =3D RESOLV_RETRY_INFINITE;</div><div>=C2=A0 =C2=A0o-&gt;proto_force =3D =
-1;</div><div>+</div><div>+#ifdef ENABLE_CLIENT_NAT</div><div>+ =C2=A0o-&gt=
;enable_nat_ftp_support =3D false;</div><div>+#endif</div><div>+ =C2=A0</di=
v><div>=C2=A0#ifdef ENABLE_OCC</div><div>=C2=A0 =C2=A0o-&gt;occ =3D true;</=
div><div>=C2=A0#endif</div><div>@@ -1535,6 +1541,8 @@ show_settings (const =
struct options *o)</div><div>=C2=A0#ifdef ENABLE_CLIENT_NAT</div><div>=C2=
=A0 =C2=A0if (o-&gt;client_nat)</div><div>=C2=A0 =C2=A0 =C2=A0print_client_=
nat_list(o-&gt;client_nat, D_SHOW_PARMS);</div><div>+</div><div>+ =C2=A0SHO=
W_BOOL(enable_nat_ftp_support);</div><div>=C2=A0#endif</div><div>=C2=A0</di=
v><div>=C2=A0#ifdef ENABLE_MANAGEMENT</div><div>@@ -5287,6 +5295,10 @@ add_=
option (struct options *options,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0cnol_=
check_alloc (options);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0add_client_nat_=
to_option_list(options-&gt;client_nat, p[1], p[2], p[3], p[4], msglevel);</=
div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0else if (streq (p[0], &quo=
t;enable_nat_ftp_support&quot;))</div><div>+ =C2=A0 =C2=A0{</div><div>+ =C2=
=A0 =C2=A0 =C2=A0options-&gt;enable_nat_ftp_support =3D true;</div><div>+ =
=C2=A0 =C2=A0}</div><div>=C2=A0#endif</div><div>=C2=A0 =C2=A0else if (streq=
 (p[0], &quot;route&quot;) &amp;&amp; p[1])</div><div>=C2=A0 =C2=A0 =C2=A0{=
</div><div>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</div>=
<div>old mode 100644</div><div>new mode 100755</div><div>index af9a47f..2b2=
7368</div><div>--- a/src/openvpn/options.h</div><div>+++ b/src/openvpn/opti=
ons.h</div><div>@@ -347,6 +347,7 @@ struct options</div><div>=C2=A0 =C2=A0b=
ool allow_pull_fqdn; /* as a client, allow server to push a FQDN for certai=
n parameters */</div><div>=C2=A0</div><div>=C2=A0#ifdef ENABLE_CLIENT_NAT</=
div><div>+ =C2=A0bool enable_nat_ftp_support;</div><div>=C2=A0 =C2=A0struct=
 client_nat_option_list *client_nat;</div><div>=C2=A0#endif</div><div>=C2=
=A0</div><div>--=C2=A0</div><div>1.7.9.5</div><div><br></div><div><br></div=
><div>From 0aa64f57ecf653cd067dbef2b2378bdfc4f9a754 Mon Sep 17 00:00:00 200=
1</div><div>From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...2063...=
..." target=3D"_blank">rafael.oliveira@...2056...</a>&gt;</div><div>Date: F=
ri, 14 Aug 2015 16:46:13 -0300</div><div>Subject: [PATCH] Removed debug mes=
sages.</div><div><br></div><div><br></div><div>Signed-off-by: Rafael Gava &=
lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=3D"_blank">rafael.o=
liveira@...2056...</a>&gt;</div><div>---</div><div>=C2=A0src/openvpn/clinat=
.c | =C2=A0 =C2=A02 ++</div><div>=C2=A01 file changed, 2 insertions(+)</div=
><div><br></div><div>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat=
.c</div><div>index 1d213f5..991ea75 100755</div><div>--- a/src/openvpn/clin=
at.c</div><div>+++ b/src/openvpn/clinat.c</div><div>@@ -833,7 +833,9 @@ cli=
ent_nat_ftp_transform(struct buffer *ipbuf,</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (OPENVPN_TCPH_FIN_MASK &amp; hdr-&gt;u.tcp.flags)=C2=
=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;marked_to_=
remove =3D 1;</div><div>+#if DEBUG_DELTA =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0msg (M_INFO, &quot;Delta marked to be removed!&quot;);</div><div>+#en=
dif</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=
=C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 1;=
=C2=A0</div><div>--=C2=A0</div><div>1.7.9.5</div><div><br></div><div><br></=
div><div>From cf7af4e4784c83a64b8c1e12601d33bdc5b14d59 Mon Sep 17 00:00:00 =
2001</div><div>From: Rafael Gava &lt;<a href=3D"mailto:rafael.oliveira@...1665...=
056..." target=3D"_blank">rafael.oliveira@...2056...</a>&gt;</div><div>Date=
: Thu, 20 Aug 2015 08:47:08 -0300</div><div>Subject: [PATCH] Fixed FTP NAT =
IP address.</div><div><br></div><div><br></div><div>Signed-off-by: Rafael G=
ava &lt;<a href=3D"mailto:rafael.oliveira@...2056..." target=3D"_blank">raf=
ael.oliveira@...2056...</a>&gt;</div><div>---</div><div>=C2=A0src/openvpn/c=
linat.c | =C2=A0 30 +++++++++++++++---------------</div><div>=C2=A01 file c=
hanged, 15 insertions(+), 15 deletions(-)</div><div><br></div><div>diff --g=
it a/src/openvpn/clinat.c b/src/openvpn/clinat.c</div><div>index 991ea75..e=
f400de 100755</div><div>--- a/src/openvpn/clinat.c</div><div>+++ b/src/open=
vpn/clinat.c</div><div>@@ -423,7 +423,7 @@ static int try_number(const char=
 *data, size_t dlen, uint32_t array[],</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (*data =3D=3D term &amp;&amp; i =3D=3D array_size - 1)</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;</div><div>=C2=A0</div><div>- =C2=
=A0 =C2=A0 =C2=A0msg (M_ERRNO, &quot;CNAT - try_number - Char %u (got %u nu=
ms) `%u&#39; unexpected\n&quot;, len, i, *data);</div><div>+ =C2=A0 =C2=A0 =
=C2=A0msg (M_ERRNO, &quot;CNAT - try_number - Char %u (got %u nums) &#39;%u=
&#39; unexpected\n&quot;, len, i, *data);</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0return 0;</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0}</d=
iv><div>@@ -433,7 +433,7 @@ static int try_number(const char *data, size_t =
dlen, uint32_t array[],</div><div>=C2=A0 =C2=A0return 0;</div><div>=C2=A0}<=
/div><div>=C2=A0</div><div>-static int try_rfc959(const char *, size_t, u_i=
nt32_t [], char);</div><div>+static int try_rfc959(const char *, size_t, ui=
nt32_t [], char);</div><div>=C2=A0</div><div>=C2=A0static struct ftp_search=
 {</div><div>=C2=A0 =C2=A0int direction;</div><div>@@ -441,7 +441,7 @@ stat=
ic struct ftp_search {</div><div>=C2=A0 =C2=A0size_t plen;</div><div>=C2=A0=
 =C2=A0char skip;</div><div>=C2=A0 =C2=A0char term;</div><div>- =C2=A0int (=
*getnum)(const char *, size_t, u_int32_t[], char);</div><div>+ =C2=A0int (*=
getnum)(const char *, size_t, uint32_t[], char);</div><div>=C2=A0} search[]=
 =3D {</div><div>=C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0CN_OUTGOING,<=
/div><div>@@ -458,7 +458,7 @@ static struct ftp_search {</div><div>=C2=A0</=
div><div>=C2=A0/* Returns 0, or length of numbers: 192,168,1,1,5,6 */</div>=
<div>=C2=A0static int=C2=A0</div><div>-try_rfc959(const char *data, size_t =
dlen, u_int32_t array[6],</div><div>+try_rfc959(const char *data, size_t dl=
en, uint32_t array[6],</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
char term)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0return try_number(data,=
 dlen, array, 6, &#39;,&#39;, term);</div><div>@@ -467,9 +467,9 @@ try_rfc9=
59(const char *data, size_t dlen, u_int32_t array[6],</div><div>=C2=A0/* Gr=
ab port: number up to delimiter */</div><div>=C2=A0static int=C2=A0</div><d=
iv>=C2=A0get_port(const char *data, int start, size_t dlen, char delim,</di=
v><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0u_int32_t array[2])</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t array[2])</div><div>=C2=A0{</div><div>- =C2=A0=
u_int16_t port =3D 0;</div><div>+ =C2=A0uint16_t port =3D 0;</div><div>=C2=
=A0 =C2=A0int i;</div><div>=C2=A0</div><div>=C2=A0 =C2=A0for (i =3D start; =
i &lt; dlen; i++) {</div><div>@@ -496,13 +496,13 @@ find_pattern(const char=
 *data, size_t dlen,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0char skip, char t=
erm,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *numoff,</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *numlen,</div><div>- =C2=A0 =C2=A0 =
=C2=A0u_int32_t array[6],</div><div>- =C2=A0 =C2=A0 =C2=A0int (*getnum)(con=
st char *, size_t, u_int32_t[], char))</div><div>+ =C2=A0 =C2=A0 =C2=A0uint=
32_t array[6],</div><div>+ =C2=A0 =C2=A0 =C2=A0int (*getnum)(const char *, =
size_t, uint32_t[], char))</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0size_t =
i;</div><div>=C2=A0</div><div>=C2=A0 =C2=A0if (check_debug_level (D_CLIENT_=
NAT))</div><div>- =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - find_pattern %s: d=
len =3D %u\n&quot;, pattern, dlen);</div><div>+ =C2=A0 =C2=A0msg (M_INFO, &=
quot;CNAT - find_pattern %s: dlen =3D %u\n&quot;, pattern, (uint32_t) dlen)=
;</div><div>=C2=A0</div><div>=C2=A0 =C2=A0if (dlen =3D=3D 0)</div><div>=C2=
=A0 =C2=A0 =C2=A0return 0;</div><div>@@ -530,7 +530,7 @@ find_pattern(const=
 char *data, size_t dlen,</div><div>=C2=A0 =C2=A0i++;</div><div>=C2=A0</div=
><div>=C2=A0 =C2=A0if (check_debug_level (D_CLIENT_NAT))</div><div>- =C2=A0=
 =C2=A0msg (M_INFO, &quot;CNAT - Skipped up to `%c&#39;!\n&quot;, skip);</d=
iv><div>+ =C2=A0 =C2=A0msg (M_INFO, &quot;CNAT - Skipped up to &#39;%c&#39;=
 (%d)!\n&quot;, skip, skip);</div><div>=C2=A0</div><div>=C2=A0 =C2=A0*numof=
f =3D i;</div><div>=C2=A0 =C2=A0*numlen =3D getnum(data + i, dlen - i, arra=
y, term);</div><div>@@ -652,7 +652,7 @@ client_nat_ftp_transform(struct buf=
fer *ipbuf,</div><div>=C2=A0 =C2=A0hexdump(tcp_data, BLEN(&amp;tcpbuf)); =
=C2=A0 =C2=A0</div><div>=C2=A0#endif</div><div>=C2=A0</div><div>- =C2=A0u_i=
nt32_t matchlen, matchoff;</div><div>+ =C2=A0uint32_t matchlen, matchoff;</=
div><div>=C2=A0 =C2=A0int found_pattern =3D -1;</div><div>=C2=A0 =C2=A0int =
i =3D 0;</div><div>=C2=A0</div><div>@@ -689,7 +689,7 @@ client_nat_ftp_tran=
sform(struct buffer *ipbuf,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t ne=
w_tcp_data[32];</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;new_tcp_da=
ta[0], 0, sizeof(new_tcp_data));</div><div>=C2=A0</div><div>- =C2=A0 =C2=A0=
 =C2=A0int new_len =3D sprintf((char *) &amp;new_tcp_data[0], &quot;%d,%d,%=
d,%d,%d,%d%.*s&quot;,</div><div>+ =C2=A0 =C2=A0 =C2=A0int new_len =3D sprin=
tf((char *) &amp;new_tcp_data[0], &quot;%03d,%03d,%03d,%03d,%03d,%03d%.*s&q=
uot;,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_tmp[0], addr_tmp[1],=
 addr_tmp[2], addr_tmp[3], array[4], array[5],=C2=A0</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0data_len - matchlen, (char *)&amp;tcp_data[matchoff=
 + matchlen]);</div><div>=C2=A0</div><div>@@ -700,7 +700,7 @@ client_nat_ft=
p_transform(struct buffer *ipbuf,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0//If the new len=
 is greater than the old, there will be there an adjustment</div><div>- =C2=
=A0 =C2=A0 =C2=A0if (new_len &gt; data_len)=C2=A0</div><div>+ =C2=A0 =C2=A0=
 =C2=A0if (replace_address !=3D ip &amp;&amp; new_len &gt; data_len)=C2=A0<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0//If the entry already exists</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry =3D get_delta_entry(table, delta_k=
ey))=C2=A0</div><div>@@ -765,8 +765,8 @@ client_nat_ftp_transform(struct bu=
ffer *ipbuf,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0else</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</di=
v><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// The replace size is the lesse=
r or iqual the original? Pad with 0 if necessary.</div><div>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;tcp_data[matchoff], new_tcp_data, data_len=
);=C2=A0</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (replace_address =
!=3D ip)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;t=
cp_data[matchoff], new_tcp_data, data_len);=C2=A0</div><div>=C2=A0</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//If the entry already exists</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry =3D get_delta_en=
try(table, delta_key))=C2=A0</div><div>--=C2=A0</div><div>1.7.9.5</div><div=
><br></div><div><br></div><div>From 63b1ddad1628eb1a179c2bf5010b781284d2bc4=
f Mon Sep 17 00:00:00 2001</div><div>From: Rafael Gava &lt;<a href=3D"mailt=
o:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...<=
/a>&gt;</div><div>Date: Sat, 15 Aug 2015 16:58:45 -0300</div><div>Subject: =
[PATCH] Fixed options parameter name enable-nat-ftp-support.</div><div><br>=
</div><div><br></div><div>Signed-off-by: Rafael Gava &lt;<a href=3D"mailto:=
rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2056...</a=
>&gt;</div><div>---</div><div>=C2=A0src/openvpn/options.c | =C2=A0 =C2=A02 =
+-</div><div>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)</div><div>=
<br></div><div>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</=
div><div>index 73b615a..1a012e4 100755</div><div>--- a/src/openvpn/options.=
c</div><div>+++ b/src/openvpn/options.c</div><div>@@ -5295,7 +5295,7 @@ add=
_option (struct options *options,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0cnol=
_check_alloc (options);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0add_client_nat=
_to_option_list(options-&gt;client_nat, p[1], p[2], p[3], p[4], msglevel);<=
/div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>- =C2=A0else if (streq (p[0], &qu=
ot;enable_nat_ftp_support&quot;))</div><div>+ =C2=A0else if (streq (p[0], &=
quot;enable-nat-ftp-support&quot;))</div><div>=C2=A0 =C2=A0 =C2=A0{</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;enable_nat_ftp_support =3D true;<=
/div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>--=C2=A0</div><div>1.7.9.5</div><=
div><br></div><div><br></div><div>From 2f5ac96c0c2c5d9d06a11e0b08ae958e09c2=
e9b5 Mon Sep 17 00:00:00 2001</div><div>From: Rafael Gava &lt;<a href=3D"ma=
ilto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...2059...=
..</a>&gt;</div><div>Date: Mon, 24 Aug 2015 09:15:34 -0300</div><div>Subjec=
t: [PATCH] Allows set yes/no option to enable-nat-ftp-support feature.</div=
><div><br></div><div><br></div><div>Signed-off-by: Rafael Gava &lt;<a href=
=3D"mailto:rafael.oliveira@...2056..." target=3D"_blank">rafael.oliveira@...1186...=
.2056...</a>&gt;</div><div>---</div><div>=C2=A0src/openvpn/options.c | =C2=
=A0 21 +++++++++++++++++++--</div><div>=C2=A01 file changed, 19 insertions(=
+), 2 deletions(-)</div><div><br></div><div>diff --git a/src/openvpn/option=
s.c b/src/openvpn/options.c</div><div>index 1a012e4..4d73d87 100755</div><d=
iv>--- a/src/openvpn/options.c</div><div>+++ b/src/openvpn/options.c</div><=
div>@@ -236,7 +236,9 @@ static const char usage_message[] =3D</div><div>=C2=
=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0the default gateway.=C2=A0 Useful when pushing private subnets.\n&quo=
t;</div><div>=C2=A0#ifdef ENABLE_CLIENT_NAT</div><div>=C2=A0 =C2=A0&quot;--=
client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.=
\n&quot;</div><div>- =C2=A0&quot;--enable-nat-ftp-support : Enable NAT FTP =
Support, updating the IP address on FTP PORT commands or PASV responses\n&q=
uot; =C2=A0</div><div>+ =C2=A0&quot;--enable-nat-ftp-support : Enable NAT F=
TP Support, replacing the IP address on FTP PORT commands or PASV responses=
?\n&quot; =C2=A0</div><div>+ =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;no&#39; =C2=A0 =C2=A0-- No, disable thi=
s feature.\n&quot;</div><div>+ =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;yes&#39; =C2=A0 -- Yes, enable this fea=
ture (Enabled by default on Windows).\n&quot;</div><div>=C2=A0#endif</div><=
div>=C2=A0#ifdef ENABLE_PUSH_PEER_INFO</div><div>=C2=A0 =C2=A0&quot;--push-=
peer-info : (client only) push client info to server.\n&quot;</div><div>@@ =
-792,8 +794,12 @@ init_options (struct options *o, const bool init_gc)</div=
><div>=C2=A0 =C2=A0o-&gt;proto_force =3D -1;</div><div>=C2=A0</div><div>=C2=
=A0#ifdef ENABLE_CLIENT_NAT</div><div>+#ifdef WIN32</div><div>+ =C2=A0o-&gt=
;enable_nat_ftp_support =3D true;</div><div>+#else</div><div>=C2=A0 =C2=A0o=
-&gt;enable_nat_ftp_support =3D false;</div><div>=C2=A0#endif</div><div>+#e=
ndif</div><div>=C2=A0 =C2=A0</div><div>=C2=A0#ifdef ENABLE_OCC</div><div>=
=C2=A0 =C2=A0o-&gt;occ =3D true;</div><div>@@ -5297,7 +5303,18 @@ add_optio=
n (struct options *options,</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=
=A0 =C2=A0else if (streq (p[0], &quot;enable-nat-ftp-support&quot;))</div><=
div>=C2=A0 =C2=A0 =C2=A0{</div><div>- =C2=A0 =C2=A0 =C2=A0options-&gt;enabl=
e_nat_ftp_support =3D true;</div><div>+ =C2=A0 =C2=A0 =C2=A0if (p[1])</div>=
<div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (streq (p[1], &quot;yes&quot;))</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0options-&gt;enable_nat_ftp_support =3D true;</div><div>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (streq (p[1], &quot;no&quot;))<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;enable_nat=
_ftp_support =3D false;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (msglevel, &quot;bad enable-na=
t-ftp-support option: %s -- must be &#39;yes&#39; or &#39;no&#39;&quot;, p[=
1]);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0#endi=
f</div><div>=C2=A0 =C2=A0else if (streq (p[0], &quot;route&quot;) &amp;&amp=
; p[1])</div><span class=3D"HOEnZb"><font color=3D"#888888"><div>--=C2=A0</=
div><div>1.7.9.5</div><div><br></div></font></span></div><div><br></div></d=
iv>
</blockquote></div><br></div></div>

--047d7bd76c0010b3ec051edcc8b1--

