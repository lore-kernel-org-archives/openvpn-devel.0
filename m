Message-ID: <02b601c4d6e9$fb21b1f0$0600000a@...139...>
From: "Gisle Vanem" <giva@...258...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_02B3_01C4D6F2.5CBD8350"
Subject: [Openvpn-devel] beta-18 crash
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 30 06:38:01 2004
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_02B3_01C4D6F2.5CBD8350
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Simply running "openvpn -h" causes a SIGSEGV. I was hoping '-h' would 
print the help, but obviously not. Happens with '-v' too.

Attached is the Dr. MingW crash dump. No config-file was present, btw.

--gv

------=_NextPart_000_02B3_01C4D6F2.5CBD8350
Content-Type: text/plain;
	format=flowed;
	name="openvpn-crash.txt";
	reply-type=original
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-crash.txt"

openvpn.exe caused an Access Violation at location 00401688 in module openvpn.exe Reading from location 00000000.

Registers:
eax=00000000 ebx=00000000 ecx=00002736 edx=00000000 esi=00000000 edi=0022f4cc
eip=00401688 esp=0022f470 ebp=0022f478 iopl=0         nv up ei pl nz na pe nc
cs=001b  ss=0023  ds=0023  es=0023  fs=003b  gs=0000             efl=00000202

Call stack:
00401688  openvpn.exe:00401688  buf_clear  buffer.c:99
void buf_clear(
	struct buffer * buf = &{
		int capacity = ,
		int offset = ,
		int len = ,
		unsigned char * data = 
	}
)
	...
	buf_clear (struct buffer *buf)
	{
>	  if (buf->capacity > 0)
	    memset (buf->data, 0, buf->capacity);
	  buf->len = 0;
	...

0043AD93  openvpn.exe:0043AD93  command_line_reset  manage.c:1698
void command_line_reset(
	struct command_line * cl = &{
		struct buffer buf = {
			int capacity = ,
			int offset = ,
			int len = ,
			unsigned char * data = 
		},
		struct buffer residual = {
			int capacity = ,
			int offset = ,
			int len = ,
			unsigned char * data = 
		}
	}
)
	...
	{
	  buf_clear (&cl->buf);
>	  buf_clear (&cl->residual);
	}
	
	...

0043AE54  openvpn.exe:0043AE54  man_reset_client_socket  manage.c:832
static void man_reset_client_socket(
	struct management * man = ,
	const int listen = 
)
	...
	      openvpn_close_socket (man->connection.sd_cli);
	      command_line_reset (man->connection.in);
>	      output_list_reset (man->connection.out);
	    }
	  if (listen)
	...

0043B632  openvpn.exe:0043B632  virtual_output_callback_func  manage.c:195
static void virtual_output_callback_func(
	void * arg = ,
	const unsigned int flags = 272,
	const char * str = &'I'
)
	...
	{
	  man_output_list_push (man, out);
>	  man_reset_client_socket (man, false);
	}
	    }
	...

00406C16  openvpn.exe:00406C16  x_msg  status.h:43
void x_msg(
	const unsigned int flags = 272,
	const char * format = &'I'
)
	...
	virtual_output_print (const struct virtual_output *vo, const unsigned int flags, const char *str)
	{
>	  (*vo->func) (vo->arg, flags, str);
	}
	
	...

0042498F  openvpn.exe:0042498F  read_config_file  options.c:2097
static void read_config_file(
	struct options * options = &{
		struct gc_arena gc = {
			struct gc_entry * list = 0x00000000
		},
		const char * config = 0x003f6fa2,
		int mode = 0,
		int persist_config = 0,
		int persist_mode = 0,
		const char * key_pass_file = 0x00000000,
		int show_ciphers = 0,
		int show_digests = 0,
		int show_engines = 0,
		int show_tls_ciphers = 0,
		int genkey = 0,
		const char * local = 0x00000000,
		int local_port = 1194,
		int local_port_defined = 0,
		int remote_port = 1194,
		int port_option_used = 0,
		int remote_float = 0,
		struct remote_list * remote_list = 0x00000000,
		int remote_random = 0,
		const char * ipchange = 0x00000000,
		int bind_local = 1,
		const char * dev = 0x00000000,
		const char * dev_type = 0x00000000,
		const char * dev_node = 0x00000000,
		const char * ifconfig_local = 0x00000000,
		const char * ifconfig_remote_netmask = 0x00000000,
		int ifconfig_noexec = 0,
		int ifconfig_nowarn = 0,
		int shaper = 0,
		int tun_mtu = 1500,
		int tun_mtu_extra = 0,
		int tun_mtu_extra_defined = 0,
		int link_mtu = 1500,
		int tun_mtu_defined = 0,
		int link_mtu_defined = 0,
		int proto = 0,
		int connect_retry_seconds = 5,
		int connect_retry_defined = 0,
		int mtu_discover_type = -1,
		int mtu_test = 0,
		int fragment = 0,
		int mlock = 0,
		int keepalive_ping = 0,
		int keepalive_timeout = 0,
		int inactivity_timeout = 0,
		int ping_send_timeout = 0,
		int ping_rec_timeout = 0,
		int ping_timer_remote = 0,
		int tun_ipv6 = 0,
		int ping_rec_timeout_action = 0,
		int explicit_exit_notification = 0,
		int persist_tun = 0,
		int persist_local_ip = 0,
		int persist_remote_ip = 0,
		int persist_key = 0,
		int mssfix = 1450,
		int mssfix_default = 0,
		int resolve_retry_seconds = 1000000000,
		struct tuntap_options tuntap_options = {
			int ip_win32_defined = 0,
			int ip_win32_type = 3,
			int dhcp_masq_custom_offset = 0,
			int dhcp_masq_offset = 0,
			int dhcp_lease_time = 31536000,
			int tap_sleep = 0,
			int dhcp_options = 0,
			const char * domain = 0x00000000,
			const char * netbios_scope = 0x00000000,
			int netbios_node_type = 0,
			in_addr_tuint32[] dns = (array),
			int dns_len = 0,
			in_addr_tuint32[] wins = (array),
			int wins_len = 0,
			in_addr_tuint32[] ntp = (array),
			int ntp_len = 0,
			in_addr_tuint32[] nbdd = (array),
			int nbdd_len = 0,
			int dhcp_renew = 0,
			int dhcp_pre_release = 0,
			int dhcp_release = 0
		},
		const char * username = 0x00000000,
		const char * groupname = 0x00000000,
		const char * chroot_dir = 0x00000000,
		const char * cd_dir = 0x00000000,
		const char * writepid = 0x00000000,
		const char * up_script = 0x00000000,
		const char * down_script = 0x00000000,
		int down_pre = 0,
		int up_delay = 0,
		int up_restart = 0,
		int daemon = 0,
		int remap_sigusr1 = 0,
		int inetd = 0,
		int log = 0,
		int suppress_timestamps = 0,
		int nice = 0,
		int verbosity = 1,
		int mute = 0,
		int gremlin = 0,
		const char * status_file = 0x00000000,
		int status_file_version = 1,
		int status_file_update_freq = 60,
		int fast_io = 0,
		int comp_lzo = 0,
		int comp_lzo_adaptive = 1,
		int rcvbuf = 0,
		int sndbuf = 0,
		const char * route_script = 0x00000000,
		const char * route_default_gateway = 0x00000000,
		int route_noexec = 0,
		int route_delay = 0,
		int route_delay_window = 30,
		int route_delay_defined = 0,
		struct route_option_list * routes = 0x00000000,
		const char * http_proxy_server = 0x00000000,
		int http_proxy_port = 0,
		const char * http_proxy_auth_method = 0x00000000,
		const char * http_proxy_auth_file = 0x00000000,
		int http_proxy_retry = 0,
		const char * socks_proxy_server = 0x00000000,
		int socks_proxy_port = 0,
		int socks_proxy_retry = 0,
		int occ = 1,
		const char * management_addr = 0x00000000,
		int management_port = 0,
		const char * management_user_pass = 0x00000000,
		int management_log_history_cache = 1000,
		int management_echo_buffer_size = 100,
		int management_query_passwords = 0,
		struct plugin_option_list * plugin_list = 0x00000000,
		int server_defined = 0,
		in_addr_t server_network = 0,
		in_addr_t server_netmask = 0,
		int server_bridge_defined = 0,
		in_addr_t server_bridge_ip = 0,
		in_addr_t server_bridge_netmask = 0,
		in_addr_t server_bridge_pool_start = 0,
		in_addr_t server_bridge_pool_end = 0,
		int client = 0,
		struct push_list * push_list = 0x00000000,
		int pull = 0,
		struct options_pre_pull * pre_pull = 0x00000000,
		int ifconfig_pool_defined = 0,
		in_addr_t ifconfig_pool_start = 0,
		in_addr_t ifconfig_pool_end = 0,
		in_addr_t ifconfig_pool_netmask = 0,
		const char * ifconfig_pool_persist_filename = 0x00000000,
		int ifconfig_pool_persist_refresh_freq = 600,
		int ifconfig_pool_linear = 0,
		int real_hash_size = 256,
		int virtual_hash_size = 256,
		const char * client_connect_script = 0x00000000,
		const char * client_disconnect_script = 0x00000000,
		const char * learn_address_script = 0x00000000,
		const char * tmp_dir = 0x00000000,
		const char * client_config_dir = 0x00000000,
		int ccd_exclusive = 0,
		int n_bcast_buf = 256,
		int tcp_queue_limit = 64,
		struct iroute * iroutes = 0x00000000,
		int push_ifconfig_defined = 0,
		in_addr_t push_ifconfig_local = 0,
		in_addr_t push_ifconfig_remote_netmask = 0,
		int enable_c2c = 0,
		int duplicate_cn = 0,
		int cf_max = 0,
		int cf_per = 0,
		int max_clients = 1024,
		int client_cert_not_required = 0,
		int username_as_common_name = 0,
		const char * auth_user_pass_verify_script = 0x00000000,
		int auth_user_pass_verify_script_via_file = 0,
		const char * auth_user_pass_file = 0x00000000,
		const char * shared_secret_file = 0x00000000,
		int key_direction = 0,
		int ciphername_defined = 1,
		const char * ciphername = 0x00453485,
		int authname_defined = 1,
		const char * authname = 0x0045348c,
		int keysize = 0,
		const char * engine = 0x00000000,
		int replay = 1,
		int mute_replay_warnings = 0,
		int replay_window = 64,
		int replay_time = 15,
		const char * packet_id_file = 0x00000000,
		int use_iv = 1,
		int test_crypto = 0,
		int tls_server = 0,
		int tls_client = 0,
		const char * ca_file = 0x00000000,
		const char * dh_file = 0x00000000,
		const char * cert_file = 0x00000000,
		const char * priv_key_file = 0x00000000,
		const char * pkcs12_file = 0x00000000,
		const char * cipher_list = 0x00000000,
		const char * tls_verify = 0x00000000,
		const char * tls_remote = 0x00000000,
		const char * crl_file = 0x00000000,
		int ns_cert_type = 0,
		const char * cryptoapi_cert = 0x00000000,
		int key_method = 2,
		int tls_timeout = 2,
		int renegotiate_bytes = 0,
		int renegotiate_packets = 0,
		int renegotiate_seconds = 3600,
		int handshake_window = 60,
		int transition_window = 3600,
		const char * tls_auth_file = 0x00000000,
		int single_session = 0,
		int tls_exit = 0,
		int foreign_option_index = 0,
		const char * exit_event_name = 0x00000000,
		int exit_event_initial_state = 0,
		int show_net_up = 0,
		int route_method = 0
	},
	const char * file = &'-',
	int level = 0,
	const char * top_file = &'[',
	int top_line = 1,
	int msglevel = 24576,
	unsigned int permission_mask = 4294836223,
	unsigned int * option_types_found = &,
	struct env_set * es = &{
		struct gc_arena * gc = 0x0022fc14,
		struct env_item * list = 0x00000000
	}
)
	...
	  fp = fopen (file, "r");
	  if (!fp)
>	    msg (M_ERR, "In %s:%d: Error opening configuration file: %s", top_file, top_line, file);
	
	  line_num = 0;
	...

0041FF8A  openvpn.exe:0041FF8A  add_option  options.c:2276
static int add_option(
	struct options * options = &{
		struct gc_arena gc = {
			struct gc_entry * list = 0x00000000
		},
		const char * config = 0x003f6fa2,
		int mode = 0,
		int persist_config = 0,
		int persist_mode = 0,
		const char * key_pass_file = 0x00000000,
		int show_ciphers = 0,
		int show_digests = 0,
		int show_engines = 0,
		int show_tls_ciphers = 0,
		int genkey = 0,
		const char * local = 0x00000000,
		int local_port = 1194,
		int local_port_defined = 0,
		int remote_port = 1194,
		int port_option_used = 0,
		int remote_float = 0,
		struct remote_list * remote_list = 0x00000000,
		int remote_random = 0,
		const char * ipchange = 0x00000000,
		int bind_local = 1,
		const char * dev = 0x00000000,
		const char * dev_type = 0x00000000,
		const char * dev_node = 0x00000000,
		const char * ifconfig_local = 0x00000000,
		const char * ifconfig_remote_netmask = 0x00000000,
		int ifconfig_noexec = 0,
		int ifconfig_nowarn = 0,
		int shaper = 0,
		int tun_mtu = 1500,
		int tun_mtu_extra = 0,
		int tun_mtu_extra_defined = 0,
		int link_mtu = 1500,
		int tun_mtu_defined = 0,
		int link_mtu_defined = 0,
		int proto = 0,
		int connect_retry_seconds = 5,
		int connect_retry_defined = 0,
		int mtu_discover_type = -1,
		int mtu_test = 0,
		int fragment = 0,
		int mlock = 0,
		int keepalive_ping = 0,
		int keepalive_timeout = 0,
		int inactivity_timeout = 0,
		int ping_send_timeout = 0,
		int ping_rec_timeout = 0,
		int ping_timer_remote = 0,
		int tun_ipv6 = 0,
		int ping_rec_timeout_action = 0,
		int explicit_exit_notification = 0,
		int persist_tun = 0,
		int persist_local_ip = 0,
		int persist_remote_ip = 0,
		int persist_key = 0,
		int mssfix = 1450,
		int mssfix_default = 0,
		int resolve_retry_seconds = 1000000000,
		struct tuntap_options tuntap_options = {
			int ip_win32_defined = 0,
			int ip_win32_type = 3,
			int dhcp_masq_custom_offset = 0,
			int dhcp_masq_offset = 0,
			int dhcp_lease_time = 31536000,
			int tap_sleep = 0,
			int dhcp_options = 0,
			const char * domain = 0x00000000,
			const char * netbios_scope = 0x00000000,
			int netbios_node_type = 0,
			in_addr_tuint32[] dns = (array),
			int dns_len = 0,
			in_addr_tuint32[] wins = (array),
			int wins_len = 0,
			in_addr_tuint32[] ntp = (array),
			int ntp_len = 0,
			in_addr_tuint32[] nbdd = (array),
			int nbdd_len = 0,
			int dhcp_renew = 0,
			int dhcp_pre_release = 0,
			int dhcp_release = 0
		},
		const char * username = 0x00000000,
		const char * groupname = 0x00000000,
		const char * chroot_dir = 0x00000000,
		const char * cd_dir = 0x00000000,
		const char * writepid = 0x00000000,
		const char * up_script = 0x00000000,
		const char * down_script = 0x00000000,
		int down_pre = 0,
		int up_delay = 0,
		int up_restart = 0,
		int daemon = 0,
		int remap_sigusr1 = 0,
		int inetd = 0,
		int log = 0,
		int suppress_timestamps = 0,
		int nice = 0,
		int verbosity = 1,
		int mute = 0,
		int gremlin = 0,
		const char * status_file = 0x00000000,
		int status_file_version = 1,
		int status_file_update_freq = 60,
		int fast_io = 0,
		int comp_lzo = 0,
		int comp_lzo_adaptive = 1,
		int rcvbuf = 0,
		int sndbuf = 0,
		const char * route_script = 0x00000000,
		const char * route_default_gateway = 0x00000000,
		int route_noexec = 0,
		int route_delay = 0,
		int route_delay_window = 30,
		int route_delay_defined = 0,
		struct route_option_list * routes = 0x00000000,
		const char * http_proxy_server = 0x00000000,
		int http_proxy_port = 0,
		const char * http_proxy_auth_method = 0x00000000,
		const char * http_proxy_auth_file = 0x00000000,
		int http_proxy_retry = 0,
		const char * socks_proxy_server = 0x00000000,
		int socks_proxy_port = 0,
		int socks_proxy_retry = 0,
		int occ = 1,
		const char * management_addr = 0x00000000,
		int management_port = 0,
		const char * management_user_pass = 0x00000000,
		int management_log_history_cache = 1000,
		int management_echo_buffer_size = 100,
		int management_query_passwords = 0,
		struct plugin_option_list * plugin_list = 0x00000000,
		int server_defined = 0,
		in_addr_t server_network = 0,
		in_addr_t server_netmask = 0,
		int server_bridge_defined = 0,
		in_addr_t server_bridge_ip = 0,
		in_addr_t server_bridge_netmask = 0,
		in_addr_t server_bridge_pool_start = 0,
		in_addr_t server_bridge_pool_end = 0,
		int client = 0,
		struct push_list * push_list = 0x00000000,
		int pull = 0,
		struct options_pre_pull * pre_pull = 0x00000000,
		int ifconfig_pool_defined = 0,
		in_addr_t ifconfig_pool_start = 0,
		in_addr_t ifconfig_pool_end = 0,
		in_addr_t ifconfig_pool_netmask = 0,
		const char * ifconfig_pool_persist_filename = 0x00000000,
		int ifconfig_pool_persist_refresh_freq = 600,
		int ifconfig_pool_linear = 0,
		int real_hash_size = 256,
		int virtual_hash_size = 256,
		const char * client_connect_script = 0x00000000,
		const char * client_disconnect_script = 0x00000000,
		const char * learn_address_script = 0x00000000,
		const char * tmp_dir = 0x00000000,
		const char * client_config_dir = 0x00000000,
		int ccd_exclusive = 0,
		int n_bcast_buf = 256,
		int tcp_queue_limit = 64,
		struct iroute * iroutes = 0x00000000,
		int push_ifconfig_defined = 0,
		in_addr_t push_ifconfig_local = 0,
		in_addr_t push_ifconfig_remote_netmask = 0,
		int enable_c2c = 0,
		int duplicate_cn = 0,
		int cf_max = 0,
		int cf_per = 0,
		int max_clients = 1024,
		int client_cert_not_required = 0,
		int username_as_common_name = 0,
		const char * auth_user_pass_verify_script = 0x00000000,
		int auth_user_pass_verify_script_via_file = 0,
		const char * auth_user_pass_file = 0x00000000,
		const char * shared_secret_file = 0x00000000,
		int key_direction = 0,
		int ciphername_defined = 1,
		const char * ciphername = 0x00453485,
		int authname_defined = 1,
		const char * authname = 0x0045348c,
		int keysize = 0,
		const char * engine = 0x00000000,
		int replay = 1,
		int mute_replay_warnings = 0,
		int replay_window = 64,
		int replay_time = 15,
		const char * packet_id_file = 0x00000000,
		int use_iv = 1,
		int test_crypto = 0,
		int tls_server = 0,
		int tls_client = 0,
		const char * ca_file = 0x00000000,
		const char * dh_file = 0x00000000,
		const char * cert_file = 0x00000000,
		const char * priv_key_file = 0x00000000,
		const char * pkcs12_file = 0x00000000,
		const char * cipher_list = 0x00000000,
		const char * tls_verify = 0x00000000,
		const char * tls_remote = 0x00000000,
		const char * crl_file = 0x00000000,
		int ns_cert_type = 0,
		const char * cryptoapi_cert = 0x00000000,
		int key_method = 2,
		int tls_timeout = 2,
		int renegotiate_bytes = 0,
		int renegotiate_packets = 0,
		int renegotiate_seconds = 3600,
		int handshake_window = 60,
		int transition_window = 3600,
		const char * tls_auth_file = 0x00000000,
		int single_session = 0,
		int tls_exit = 0,
		int foreign_option_index = 0,
		const char * exit_event_name = 0x00000000,
		int exit_event_initial_state = 0,
		int show_net_up = 0,
		int route_method = 0
	},
	int i = 1,
	char * * p = &0x00453491,
	const char * file = &'[',
	int line = 1,
	int level = 0,
	int msglevel = 24576,
	unsigned int permission_mask = 4294836223,
	unsigned int * option_types_found = &,
	struct env_set * es = &{
		struct gc_arena * gc = 0x0022fc14,
		struct env_item * list = 0x00000000
	}
)
	...
	options->config = p[1];
	
>	      read_config_file (options, p[1], level, file, line, msglevel, permission_mask, option_types_found, es);
	    }
	  else if (streq (p[0], "echo"))
	...

00424C7F  openvpn.exe:00424C7F  parse_argv  options.c:2137
void parse_argv(
	struct options * options = &{
		struct gc_arena gc = {
			struct gc_entry * list = 0x00000000
		},
		const char * config = 0x003f6fa2,
		int mode = 0,
		int persist_config = 0,
		int persist_mode = 0,
		const char * key_pass_file = 0x00000000,
		int show_ciphers = 0,
		int show_digests = 0,
		int show_engines = 0,
		int show_tls_ciphers = 0,
		int genkey = 0,
		const char * local = 0x00000000,
		int local_port = 1194,
		int local_port_defined = 0,
		int remote_port = 1194,
		int port_option_used = 0,
		int remote_float = 0,
		struct remote_list * remote_list = 0x00000000,
		int remote_random = 0,
		const char * ipchange = 0x00000000,
		int bind_local = 1,
		const char * dev = 0x00000000,
		const char * dev_type = 0x00000000,
		const char * dev_node = 0x00000000,
		const char * ifconfig_local = 0x00000000,
		const char * ifconfig_remote_netmask = 0x00000000,
		int ifconfig_noexec = 0,
		int ifconfig_nowarn = 0,
		int shaper = 0,
		int tun_mtu = 1500,
		int tun_mtu_extra = 0,
		int tun_mtu_extra_defined = 0,
		int link_mtu = 1500,
		int tun_mtu_defined = 0,
		int link_mtu_defined = 0,
		int proto = 0,
		int connect_retry_seconds = 5,
		int connect_retry_defined = 0,
		int mtu_discover_type = -1,
		int mtu_test = 0,
		int fragment = 0,
		int mlock = 0,
		int keepalive_ping = 0,
		int keepalive_timeout = 0,
		int inactivity_timeout = 0,
		int ping_send_timeout = 0,
		int ping_rec_timeout = 0,
		int ping_timer_remote = 0,
		int tun_ipv6 = 0,
		int ping_rec_timeout_action = 0,
		int explicit_exit_notification = 0,
		int persist_tun = 0,
		int persist_local_ip = 0,
		int persist_remote_ip = 0,
		int persist_key = 0,
		int mssfix = 1450,
		int mssfix_default = 0,
		int resolve_retry_seconds = 1000000000,
		struct tuntap_options tuntap_options = {
			int ip_win32_defined = 0,
			int ip_win32_type = 3,
			int dhcp_masq_custom_offset = 0,
			int dhcp_masq_offset = 0,
			int dhcp_lease_time = 31536000,
			int tap_sleep = 0,
			int dhcp_options = 0,
			const char * domain = 0x00000000,
			const char * netbios_scope = 0x00000000,
			int netbios_node_type = 0,
			in_addr_tuint32[] dns = (array),
			int dns_len = 0,
			in_addr_tuint32[] wins = (array),
			int wins_len = 0,
			in_addr_tuint32[] ntp = (array),
			int ntp_len = 0,
			in_addr_tuint32[] nbdd = (array),
			int nbdd_len = 0,
			int dhcp_renew = 0,
			int dhcp_pre_release = 0,
			int dhcp_release = 0
		},
		const char * username = 0x00000000,
		const char * groupname = 0x00000000,
		const char * chroot_dir = 0x00000000,
		const char * cd_dir = 0x00000000,
		const char * writepid = 0x00000000,
		const char * up_script = 0x00000000,
		const char * down_script = 0x00000000,
		int down_pre = 0,
		int up_delay = 0,
		int up_restart = 0,
		int daemon = 0,
		int remap_sigusr1 = 0,
		int inetd = 0,
		int log = 0,
		int suppress_timestamps = 0,
		int nice = 0,
		int verbosity = 1,
		int mute = 0,
		int gremlin = 0,
		const char * status_file = 0x00000000,
		int status_file_version = 1,
		int status_file_update_freq = 60,
		int fast_io = 0,
		int comp_lzo = 0,
		int comp_lzo_adaptive = 1,
		int rcvbuf = 0,
		int sndbuf = 0,
		const char * route_script = 0x00000000,
		const char * route_default_gateway = 0x00000000,
		int route_noexec = 0,
		int route_delay = 0,
		int route_delay_window = 30,
		int route_delay_defined = 0,
		struct route_option_list * routes = 0x00000000,
		const char * http_proxy_server = 0x00000000,
		int http_proxy_port = 0,
		const char * http_proxy_auth_method = 0x00000000,
		const char * http_proxy_auth_file = 0x00000000,
		int http_proxy_retry = 0,
		const char * socks_proxy_server = 0x00000000,
		int socks_proxy_port = 0,
		int socks_proxy_retry = 0,
		int occ = 1,
		const char * management_addr = 0x00000000,
		int management_port = 0,
		const char * management_user_pass = 0x00000000,
		int management_log_history_cache = 1000,
		int management_echo_buffer_size = 100,
		int management_query_passwords = 0,
		struct plugin_option_list * plugin_list = 0x00000000,
		int server_defined = 0,
		in_addr_t server_network = 0,
		in_addr_t server_netmask = 0,
		int server_bridge_defined = 0,
		in_addr_t server_bridge_ip = 0,
		in_addr_t server_bridge_netmask = 0,
		in_addr_t server_bridge_pool_start = 0,
		in_addr_t server_bridge_pool_end = 0,
		int client = 0,
		struct push_list * push_list = 0x00000000,
		int pull = 0,
		struct options_pre_pull * pre_pull = 0x00000000,
		int ifconfig_pool_defined = 0,
		in_addr_t ifconfig_pool_start = 0,
		in_addr_t ifconfig_pool_end = 0,
		in_addr_t ifconfig_pool_netmask = 0,
		const char * ifconfig_pool_persist_filename = 0x00000000,
		int ifconfig_pool_persist_refresh_freq = 600,
		int ifconfig_pool_linear = 0,
		int real_hash_size = 256,
		int virtual_hash_size = 256,
		const char * client_connect_script = 0x00000000,
		const char * client_disconnect_script = 0x00000000,
		const char * learn_address_script = 0x00000000,
		const char * tmp_dir = 0x00000000,
		const char * client_config_dir = 0x00000000,
		int ccd_exclusive = 0,
		int n_bcast_buf = 256,
		int tcp_queue_limit = 64,
		struct iroute * iroutes = 0x00000000,
		int push_ifconfig_defined = 0,
		in_addr_t push_ifconfig_local = 0,
		in_addr_t push_ifconfig_remote_netmask = 0,
		int enable_c2c = 0,
		int duplicate_cn = 0,
		int cf_max = 0,
		int cf_per = 0,
		int max_clients = 1024,
		int client_cert_not_required = 0,
		int username_as_common_name = 0,
		const char * auth_user_pass_verify_script = 0x00000000,
		int auth_user_pass_verify_script_via_file = 0,
		const char * auth_user_pass_file = 0x00000000,
		const char * shared_secret_file = 0x00000000,
		int key_direction = 0,
		int ciphername_defined = 1,
		const char * ciphername = 0x00453485,
		int authname_defined = 1,
		const char * authname = 0x0045348c,
		int keysize = 0,
		const char * engine = 0x00000000,
		int replay = 1,
		int mute_replay_warnings = 0,
		int replay_window = 64,
		int replay_time = 15,
		const char * packet_id_file = 0x00000000,
		int use_iv = 1,
		int test_crypto = 0,
		int tls_server = 0,
		int tls_client = 0,
		const char * ca_file = 0x00000000,
		const char * dh_file = 0x00000000,
		const char * cert_file = 0x00000000,
		const char * priv_key_file = 0x00000000,
		const char * pkcs12_file = 0x00000000,
		const char * cipher_list = 0x00000000,
		const char * tls_verify = 0x00000000,
		const char * tls_remote = 0x00000000,
		const char * crl_file = 0x00000000,
		int ns_cert_type = 0,
		const char * cryptoapi_cert = 0x00000000,
		int key_method = 2,
		int tls_timeout = 2,
		int renegotiate_bytes = 0,
		int renegotiate_packets = 0,
		int renegotiate_seconds = 3600,
		int handshake_window = 60,
		int transition_window = 3600,
		const char * tls_auth_file = 0x00000000,
		int single_session = 0,
		int tls_exit = 0,
		int foreign_option_index = 0,
		const char * exit_event_name = 0x00000000,
		int exit_event_initial_state = 0,
		int show_net_up = 0,
		int route_method = 0
	},
	int argc = 2,
	char * * argv = &0x003f6f95,
	int msglevel = 24576,
	unsigned int permission_mask = 4294836223,
	unsigned int * option_types_found = &,
	struct env_set * es = &{
		struct gc_arena * gc = 0x0022fc14,
		struct env_item * list = 0x00000000
	}
)
	...
	      p[0] = "config";
	      p[1] = argv[1];
>	      add_option (options, 0, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
	    }
	  else
	...

004181A1  openvpn.exe:004181A1  main  openvpn.c:145
int main(
	int argc = 2,
	char * * argv = &0x003f6f95
)
	...
	
	  /* init verbosity and mute levels */
>	  init_verb_mute (&c, IVM_LEVEL_1);
	
	  /* set dev options */
	...

004011E7  openvpn.exe:004011E7
00401238  openvpn.exe:00401238
7C816D4F  kernel32.dll:7C816D4F  RegisterWaitForInputIdle

------=_NextPart_000_02B3_01C4D6F2.5CBD8350--



