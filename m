MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 1 Feb 2020 17:43:12 +0500
Message-ID: <CAFHpkQFTJQ_6s7Ux4G6TMye_mk+kb3P=FmOqMJYMSLBsBfXatA@...278...>
Content-Type: multipart/alternative; boundary="00000000000021052a059d83098a"
Subject: [Openvpn-devel] linux arm64 tests fail
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000021052a059d83098a
Content-Type: text/plain; charset="UTF-8"

Hello,

https://travis-ci.org/chipitsine/openvpn/jobs/644745481?utm_medium=notification&utm_source=github_status

it indicates "ERROR" when running tests, however tests are ok after all.

[ RUN      ] tls_crypt_v2_wrap_too_long_metadata

ERROR: could not crypt: insufficient space in dst

[       OK ] tls_crypt_v2_wrap_too_long_metadata

[ RUN      ] tls_crypt_v2_wrap_unwrap_wrong_key

[       OK ] tls_crypt_v2_wrap_unwrap_wrong_key

[ RUN      ] tls_crypt_v2_wrap_unwrap_dst_too_small

[       OK ] tls_crypt_v2_wrap_unwrap_dst_too_small

[ RUN      ] test_tls_crypt_v2_write_server_key_file

[       OK ] test_tls_crypt_v2_write_server_key_file

[ RUN      ] test_tls_crypt_v2_write_client_key_file

[       OK ] test_tls_crypt_v2_write_client_key_file

[==========] 14 test(s) run.

[  PASSED  ] 14 test(s).

PASS: tls_crypt_testdriver



Cheers,

Ilya Shipitcin

--00000000000021052a059d83098a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div><a href=3D"https://tr=
avis-ci.org/chipitsine/openvpn/jobs/644745481?utm_medium=3Dnotification&amp=
;utm_source=3Dgithub_status">https://travis-ci.org/chipitsine/openvpn/jobs/=
644745481?utm_medium=3Dnotification&amp;utm_source=3Dgithub_status</a></div=
><div><br></div><div>it indicates &quot;ERROR&quot; when running tests, how=
ever tests are ok after all.</div><div><br></div><div><pre id=3D"gmail-log"=
 class=3D"gmail-ansi gmail-log-body-content"><div class=3D"gmail-log-line">=
<span id=3D"gmail-106-39">[ RUN      ] tls_crypt_v2_wrap_too_long_metadata<=
/span></div></pre><pre id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-=
content"><div class=3D"gmail-log-line gmail-highlight"><span id=3D"gmail-10=
6-40">ERROR: could not crypt: insufficient space in dst</span></div></pre><=
pre id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"><div class=
=3D"gmail-log-line"><span id=3D"gmail-106-41">[      </span><span id=3D"gma=
il-107-0"> OK ] tls_crypt_v2_wrap_too_long_metadata</span></div></pre><pre =
id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"><div class=3D"=
gmail-log-line"><span id=3D"gmail-107-1">[ RUN      ] tls_crypt_v2_wrap_unw=
rap_wrong_key</span></div></pre><pre id=3D"gmail-log" class=3D"gmail-ansi g=
mail-log-body-content"><div class=3D"gmail-log-line"><span id=3D"gmail-107-=
2">[       OK ] tls_crypt_v2_wrap_unwrap_wrong_key</span></div></pre><pre i=
d=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"><div class=3D"g=
mail-log-line"><span id=3D"gmail-107-3">[ RUN      ] tls_crypt_v2_wrap_unwr=
ap_dst_too_small</span></div></pre><pre id=3D"gmail-log" class=3D"gmail-ans=
i gmail-log-body-content"><div class=3D"gmail-log-line"><span id=3D"gmail-1=
07-4">[       OK ] tls_crypt_v2_wrap_unwrap_dst_too_small</span></div></pre=
><pre id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"><div cla=
ss=3D"gmail-log-line"><span id=3D"gmail-107-5">[ RUN      ] test_tls_crypt_=
v2_write_server_key_file</span></div></pre><pre id=3D"gmail-log" class=3D"g=
mail-ansi gmail-log-body-content"><div class=3D"gmail-log-line"><span id=3D=
"gmail-107-6">[       OK ] test_tls_crypt_v2_write_server_key_file</span></=
div></pre><pre id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"=
><div class=3D"gmail-log-line"><span id=3D"gmail-107-7">[ RUN      ] test_t=
ls_crypt_v2_write_client_key_file</span></div></pre><pre id=3D"gmail-log" c=
lass=3D"gmail-ansi gmail-log-body-content"><div class=3D"gmail-log-line"><s=
pan id=3D"gmail-107-8">[       OK ] test_tls_crypt_v2_write_client_key_file=
</span></div></pre><pre id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body=
-content"><div class=3D"gmail-log-line"><span id=3D"gmail-107-9">[=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D] 14 test(s) run.</span></div></pre><pre id=3D"gmail-l=
og" class=3D"gmail-ansi gmail-log-body-content"><div class=3D"gmail-log-lin=
e"><span id=3D"gmail-107-10">[  PASSED  ] 14 test(s).</span></div></pre><pr=
e id=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"><span id=3D"=
gmail-107-11">PASS: tls_crypt_testdriver<br><br><br><br></span></pre><pre i=
d=3D"gmail-log" class=3D"gmail-ansi gmail-log-body-content"><span id=3D"gma=
il-107-11">Cheers,<br></span></pre><pre id=3D"gmail-log" class=3D"gmail-ans=
i gmail-log-body-content"><span id=3D"gmail-107-11">Ilya Shipitcin<br></spa=
n></pre></div></div>

--00000000000021052a059d83098a--

