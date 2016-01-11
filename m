MIME-Version: 1.0
Date: Mon, 11 Jan 2016 14:01:55 +0500
Message-ID: <CAFHpkQGmM2h-gQLLiTG5FFucjNF5yr0tO4YTmdCL0+O7NS2S3g@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11c3cb344ada8e05290b3016
Subject: [Openvpn-devel] unused functions (as a result of cppcheck testing)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c3cb344ada8e05290b3016
Content-Type: text/plain; charset=UTF-8

Hello,

cppcheck found several unused functions:

[src/openvpn/misc.c:842]: (style) The function 'setenv_int_i' is never used.
[src/openvpn/misc.c:669]: (style) The function 'env_set_add_to_environment'
is never used.
[src/openvpn/misc.c:627]: (style) The function 'env_set_print' is never
used.
[src/openvpn/misc.c:693]: (style) The function
'env_set_remove_from_environment' is never used.
[src/openvpn/crypto_openssl.c:580]: (style) The function 'cipher_ctx_mode'
is never used.
[src/openvpnserv/openvpnserv.c:182]: (style) The function 'close_if_open'
is never used.
[src/openvpn/buffer.c:296]: (style) The function 'convert_to_one_line' is
never used.
[src/openvpn/proxy.c:259]: (style) The function 'dump_residual' is never
used.
[src/openvpn/manage.c:3325]: (style) The function
'management_should_daemonize' is never used.
[src/openvpn/crypto_openssl.c:697]: (style) The function 'md_ctx_size' is
never used.
[src/openvpn/platform.c:253]: (style) The function
'platform_sleep_until_signal' is never used.
[src/openvpn/plugin.c:867]: (style) The function 'plugin_return_print' is
never used.
[src/openvpn/route.c:1258]: (style) The function 'print_routes' is never
used.
[src/openvpn/ssl.c:1766]: (style) The function 'read_string_discard' is
never used.
[src/openvpn/win32.c:710]: (style) The function 'semaphore_clear' is never
used.
[src/openvpn/ssl_openssl.c:709]: (style) The function
'tls_ctx_free_cert_file' is never used.

(somehow, it sees either openssl or polarssl implementation), what about
those functions ? should we remove those which are not really used ?

Cheers,
Ilya Shipitsin

--001a11c3cb344ada8e05290b3016
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello,<br><br></div>cppcheck found sev=
eral unused functions:<br><br>[src/openvpn/misc.c:842]: (style) The functio=
n &#39;setenv_int_i&#39; is never used.<br>[src/openvpn/misc.c:669]: (style=
) The function &#39;env_set_add_to_environment&#39; is never used.<br>[src/=
openvpn/misc.c:627]: (style) The function &#39;env_set_print&#39; is never =
used.<br>[src/openvpn/misc.c:693]: (style) The function &#39;env_set_remove=
_from_environment&#39; is never used.<br>[src/openvpn/crypto_openssl.c:580]=
: (style) The function &#39;cipher_ctx_mode&#39; is never used.<br>[src/ope=
nvpnserv/openvpnserv.c:182]: (style) The function &#39;close_if_open&#39; i=
s never used.<br>[src/openvpn/buffer.c:296]: (style) The function &#39;conv=
ert_to_one_line&#39; is never used.<br>[src/openvpn/proxy.c:259]: (style) T=
he function &#39;dump_residual&#39; is never used.<br>[src/openvpn/manage.c=
:3325]: (style) The function &#39;management_should_daemonize&#39; is never=
 used.<br>[src/openvpn/crypto_openssl.c:697]: (style) The function &#39;md_=
ctx_size&#39; is never used.<br>[src/openvpn/platform.c:253]: (style) The f=
unction &#39;platform_sleep_until_signal&#39; is never used.<br>[src/openvp=
n/plugin.c:867]: (style) The function &#39;plugin_return_print&#39; is neve=
r used.<br>[src/openvpn/route.c:1258]: (style) The function &#39;print_rout=
es&#39; is never used.<br>[src/openvpn/ssl.c:1766]: (style) The function &#=
39;read_string_discard&#39; is never used.<br>[src/openvpn/win32.c:710]: (s=
tyle) The function &#39;semaphore_clear&#39; is never used.<br>[src/openvpn=
/ssl_openssl.c:709]: (style) The function &#39;tls_ctx_free_cert_file&#39; =
is never used.<br><br></div>(somehow, it sees either openssl or polarssl im=
plementation), what about those functions ? should we remove those which ar=
e not really used ?<br><br></div>Cheers,<br></div>Ilya Shipitsin<br><div><d=
iv><div><div><div><br></div></div></div></div></div></div>

--001a11c3cb344ada8e05290b3016--

