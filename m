Message-ID: <55DDB89A.6030105@...1147...>
Date: Wed, 26 Aug 2015 15:01:14 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
In-Reply-To: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Rafael Gava wrote:
>
> this is my first submission to the list and I hope that I'm doing in 
> the right way. :-)
>
>
> Well, the features added to Network Address Translator are:
>
> 1) Allow the user to use the string "localhost" on the client-nat 
> network configuration in a way that is not necessary to inform the IP 
> address beforehand. Openvpn will set the dynamic received IP from DHCP. 
> Example:
>
> client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the 
> 'localhost' string with the DHCP address received from openvpn server.
>
I understand the idea behind it but it would be a NACK from me on the 
string "localhost" - to me, localhost is 127.0.0.1 or ::1, not the 
DHCP-IP ; perhaps use something like "client-ip"   ?


> 2) Allow the user to enable the FTP NAT support through the 
> --enable-nat-ftp-support option. 
> This is useful for systems that don't have conntrack-tools support, 
> for example on Windows systems. On windows this feature is enabled by 
> default.
>
> enable-nat-ftp-support (yes | no)
>
sounds like a useful feature to me.


JJK

>
> The following patch was written based on release/2.3 branch.
> --------------------------------------------------------------------------------------------------------------------------------------
>
> From d11957a025dc6c113874e7b04ce4c8e9513c3b02 Mon Sep 17 00:00:00 2001
> From: venturus <venturus@...2055...(none)>
> Date: Thu, 13 Aug 2015 08:26:36 -0300
> Subject: [PATCH] Replaces the client-nat network string 'localhost' 
> with the
>  dynamic IP set to the tun/tap interface by the openvpn
>  server. Example:
>
> --client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the 
> 'localhost' string with the DHCP address received from openvpn server.
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
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
> +bool update_localhost_nat(struct client_nat_option_list *dest, 
> in_addr_t local_ip);
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
> From: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> Date: Fri, 14 Aug 2015 15:27:50 -0300
> Subject: [PATCH] Added FTP NAT support. This feature can be enabled via
>  --enable-nat-ftp-support option.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
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
> +    printf("from %d -> to %d: removed: %s, timestamp: %d, delta_out: 
> %d, delta_in: %d\n", 
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
> @@ -192,19 +345,533 @@ print_pkt (struct openvpn_iphdr *iph, const 
> char *prefix, const int direction, c
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
> +    word16 = ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_tcp) ? 
> (buf[i+1] & 0xFF) : 0);
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
> +  /* keep only the last 16 bits of the 32 bit calculated sum and add 
> the carries */
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
> +      //If the new len is greater than the old, there will be there 
> an adjustment
> +      if (new_len > data_len) 
> +        {
> +          //If the entry already exists
> +          if (entry = get_delta_entry(table, delta_key)) 
> +            {
> +              if (direction == CN_OUTGOING) 
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) + 
> (entry->delta_out));       // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = 
> htonl(ntohl(hdr->u.tcp.ack_seq) - entry->delta_in);
> +                  entry->delta_out += new_len - data_len;
> +                }
> +              else
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) + 
> (entry->delta_in));        // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = 
> htonl(ntohl(hdr->u.tcp.ack_seq) - entry->delta_out);
> +                  entry->delta_in += new_len - data_len;
> +                }
> +              //Update timestamp entry on delta entry, to keep this 
> delta alive
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
> +          // The replace size is the lesser or iqual the original? 
> Pad with 0 if necessary.
> +          memcpy(&tcp_data[matchoff], new_tcp_data, data_len); 
> +
> +          //If the entry already exists
> +          if (entry = get_delta_entry(table, delta_key)) 
> +            {
> +              if (direction == CN_OUTGOING) 
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) + 
> (entry->delta_out));       // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = 
> htonl(ntohl(hdr->u.tcp.ack_seq) - entry->delta_in);
> +                }
> +              else
> +                {
> +                  hdr->u.tcp.seq = htonl(ntohl(hdr->u.tcp.seq) + 
> (entry->delta_in));        // Need to update seq and ack
> +                  hdr->u.tcp.ack_seq = 
> htonl(ntohl(hdr->u.tcp.ack_seq) - entry->delta_out);
> +                }
> +              //Update timestamp entry on delta entry, to keep this 
> delta alive
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
> +          msg (M_INFO, "Regular package!: tot_len %d, seq %x, ack 
> %x\n", ntohs(hdr->ip.tot_len), ntohl(hdr->u.tcp.seq), 
> ntohl(hdr->u.tcp.ack_seq));
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
>        const struct client_nat_entry *e = &list->entries[i]; /* 
> current NAT rule */
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
> +          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + 
> sizeof(struct openvpn_tcphdr))
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
> +          if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + 
> sizeof(struct openvpn_udphdr))
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
> +          msg (M_INFO, "CNAT - Updating NAT table from localhost to: 
> %s", dot_ip); 
>            ret = true;
>          }
>      }
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> index ce995d9..a58da5d 100755
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -52,15 +52,16 @@ void copy_client_nat_option_list (struct 
> client_nat_option_list *dest, const str
>  void print_client_nat_list(const struct client_nat_option_list *list, 
> int msglevel);
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
>  bool update_localhost_nat(struct client_nat_option_list *dest, 
> in_addr_t local_ip);
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
>        process_ip_header (c, 
> PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf);
>  
> +      if (c->c2.buf.len > 0)
> +        c->c2.tun_read_bytes += c->c2.buf.len;
> +
>  #ifdef PACKET_TRUNCATION_CHECK
>        /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
>        ipv4_packet_size_verify (BPTR (&c->c2.buf),
> @@ -1041,43 +1041,44 @@ process_ip_header (struct context *c, unsigned 
> int flags, struct buffer *buf)
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
> -    route_list_add_vpn_gateway (c->c1.route_list, c->c2.es 
> <http://c2.es>, dhcp_router);
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
> +                  const in_addr_t dhcp_router = 
> dhcp_extract_router_msg (buf);
> +                  if (dhcp_router)
> +                    route_list_add_vpn_gateway (c->c1.route_list, 
> c->c2.es <http://c2.es>, dhcp_router);
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
>    "                  the default gateway.  Useful when pushing 
> private subnets.\n"
>  #ifdef ENABLE_CLIENT_NAT
>    "--client-nat snat|dnat network netmask alias : on client add 
> 1-to-1 NAT rule.\n"
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
>    bool allow_pull_fqdn; /* as a client, allow server to push a FQDN 
> for certain parameters */
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
> From: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> Date: Fri, 14 Aug 2015 16:46:13 -0300
> Subject: [PATCH] Removed debug messages.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
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
> From: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> Date: Thu, 20 Aug 2015 08:47:08 -0300
> Subject: [PATCH] Fixed FTP NAT IP address.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> ---
>  src/openvpn/clinat.c |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 991ea75..ef400de 100755
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -423,7 +423,7 @@ static int try_number(const char *data, size_t 
> dlen, uint32_t array[],
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
> @@ -433,7 +433,7 @@ static int try_number(const char *data, size_t 
> dlen, uint32_t array[],
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
> @@ -467,9 +467,9 @@ try_rfc959(const char *data, size_t dlen, 
> u_int32_t array[6],
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
>        //If the new len is greater than the old, there will be there 
> an adjustment
> -      if (new_len > data_len) 
> +      if (replace_address != ip && new_len > data_len) 
>          {
>            //If the entry already exists
>            if (entry = get_delta_entry(table, delta_key)) 
> @@ -765,8 +765,8 @@ client_nat_ftp_transform(struct buffer *ipbuf,
>          }
>        else
>          {
> -          // The replace size is the lesser or iqual the original? 
> Pad with 0 if necessary.
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
> From: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> Date: Sat, 15 Aug 2015 16:58:45 -0300
> Subject: [PATCH] Fixed options parameter name enable-nat-ftp-support.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
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
> From: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> Date: Mon, 24 Aug 2015 09:15:34 -0300
> Subject: [PATCH] Allows set yes/no option to enable-nat-ftp-support 
> feature.
>
>
> Signed-off-by: Rafael Gava <rafael.oliveira@...2056... 
> <mailto:rafael.oliveira@...2056...>>
> ---
>  src/openvpn/options.c |   21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 1a012e4..4d73d87 100755
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -236,7 +236,9 @@ static const char usage_message[] =
>    "                  the default gateway.  Useful when pushing 
> private subnets.\n"
>  #ifdef ENABLE_CLIENT_NAT
>    "--client-nat snat|dnat network netmask alias : on client add 
> 1-to-1 NAT rule.\n"
> -  "--enable-nat-ftp-support : Enable NAT FTP Support, updating the IP 
> address on FTP PORT commands or PASV responses\n"  
> +  "--enable-nat-ftp-support : Enable NAT FTP Support, replacing the 
> IP address on FTP PORT commands or PASV responses?\n"  
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
> +              msg (msglevel, "bad enable-nat-ftp-support option: %s 
> -- must be 'yes' or 'no'", p[1]);
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
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>   


