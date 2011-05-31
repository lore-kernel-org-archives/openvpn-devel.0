Message-ID: <4DE4F116.2000904@...1030...>
Date: Tue, 31 May 2011 14:45:58 +0100
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4DB864E0.4060207@...515...>
In-Reply-To: <4DB864E0.4060207@...515...>
Subject: [Openvpn-devel] OpenVPN 2.2.0 build failure with
	"--disable-management"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

configure \
--build=x86_64-redhat-linux-gnu \
--host=i686-redhat-linux-gnu \
--enable-password-save \
--enable-iproute2 \
--with-ifconfig-path=/sbin/ifconfig  \
--with-iproute-path=/sbin/ip \
--with-route-path=/sbin/route \
--disable-port-share \
--disable-management

passes through, but then I get this during make:

gcc -DHAVE_CONFIG_H -I.   -I.    -O2 -g -pipe -Wall 
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector 
--param=ssp-buffer-size=4 -m32 -march=i686 -mtune=pentium2 
-fasynchronous-unwind-tables -c pkcs11.c
pkcs11.c: In function '__mytime':
pkcs11.c:40: warning: implicit declaration of function 'openvpn_time'
pkcs11.c: In function '_pkcs11_openvpn_token_prompt':
pkcs11.c:168: error: storage size of 'token_resp' isn't known
pkcs11.c:179: warning: implicit declaration of function 'openvpn_snprintf'
pkcs11.c:187: warning: implicit declaration of function 'get_user_pass'
pkcs11.c:191: error: 'GET_USER_PASS_MANAGEMENT' undeclared (first use in 
this function)
pkcs11.c:191: error: (Each undeclared identifier is reported only once
pkcs11.c:191: error: for each function it appears in.)
pkcs11.c:191: error: 'GET_USER_PASS_NEED_OK' undeclared (first use in 
this function)
pkcs11.c:191: error: 'GET_USER_PASS_NOFATAL' undeclared (first use in 
this function)
pkcs11.c:197: warning: left-hand operand of comma expression has no effect
pkcs11.c:197: warning: value computed is not used
pkcs11.c:197: warning: left-hand operand of comma expression has no effect
pkcs11.c:168: warning: unused variable 'token_resp'
pkcs11.c: In function '_pkcs11_openvpn_pin_prompt':
pkcs11.c:211: error: storage size of 'token_pass' isn't known
pkcs11.c:230: error: 'GET_USER_PASS_MANAGEMENT' undeclared (first use in 
this function)
pkcs11.c:230: error: 'GET_USER_PASS_PASSWORD_ONLY' undeclared (first use 
in this function)
pkcs11.c:230: error: 'GET_USER_PASS_NOFATAL' undeclared (first use in 
this function)
pkcs11.c:236: warning: implicit declaration of function 'strncpynt'
pkcs11.c:237: warning: implicit declaration of function 'purge_user_pass'
pkcs11.c:211: warning: unused variable 'token_pass'
pkcs11.c: In function 'SSL_CTX_use_pkcs11':
pkcs11.c:632: error: storage size of 'id_resp' isn't known
pkcs11.c:649: error: 'GET_USER_PASS_MANAGEMENT' undeclared (first use in 
this function)
pkcs11.c:649: error: 'GET_USER_PASS_NEED_STR' undeclared (first use in 
this function)
pkcs11.c:649: error: 'GET_USER_PASS_NOFATAL' undeclared (first use in 
this function)
pkcs11.c:632: warning: unused variable 'id_resp'
pkcs11.c: In function '_pkcs11_openvpn_show_pkcs11_ids_pin_prompt':
pkcs11.c:773: error: variable 'gc' has initializer but incomplete type
pkcs11.c:773: warning: implicit declaration of function 'gc_new'
pkcs11.c:773: error: storage size of 'gc' isn't known
pkcs11.c:774: error: variable 'pass_prompt' has initializer but 
incomplete type
pkcs11.c:774: warning: implicit declaration of function 'alloc_buf_gc'
pkcs11.c:774: error: storage size of 'pass_prompt' isn't known
pkcs11.c:782: warning: implicit declaration of function 'buf_printf'
pkcs11.c:784: warning: implicit declaration of function 'get_console_input'
pkcs11.c:784: warning: implicit declaration of function 'BSTR'
pkcs11.c:788: warning: implicit declaration of function 'gc_free'
pkcs11.c:774: warning: unused variable 'pass_prompt'
pkcs11.c:773: warning: unused variable 'gc'
make[2]: *** [pkcs11.o] Error 1
make[2]: Leaving directory `/home/me/rpmbuild/BUILD/openvpn-2.2.0'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/me/rpmbuild/BUILD/openvpn-2.2.0'
make: *** [all] Error 2

Running configure without "--disable-management" and then executing 
"make" is OK - no errors. Doing the same as above when not 
cross-compiling (i.e. build = host = x86_64-redhat-linux-gnu) with 
"--disable-management" also produces the same error (it passes through 
when "--disable-management" is removed).


