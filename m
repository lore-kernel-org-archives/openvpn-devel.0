MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Jul 2022 23:06:44 -0400
Message-ID: <CAKuzo_gRVh=Hsw_VLtjL40kbBo+tz+L39p3NjxBvW46aOFc9EA@...278...>
Content-Type: multipart/alternative; boundary="000000000000117e1f05e32e61b9"
Subject: [Openvpn-devel] Bug in msvc build of master + OpenSSL 3.0.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000117e1f05e32e61b9
Content-Type: text/plain; charset="UTF-8"

Hi,

As reported by Lev here:
https://github.com/OpenVPN/openvpn-gui/pull/508#issuecomment-1174057372

I think its due to this in xkey-provider:

typedef void (XKEY_PRIVKEY_FREE_fn)(void *handle);
(and a similar one for SIGN_fn)

EVP_PKEY *
xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op)
{
...
<code to pass &sign_op and &free_op to openssl>
...
}

(see xkey_helper. around line:120, and xkey_common.h for declarations).

Note the lack of * before the sign_op and free_op variables in the function
definition and declaration (not shown). The typedefs are without a * as
well, but that is deliberate and intentional.

This is not flagged as a bug by gcc or msvc, and it seems both
automatically assign function pointers to sign_op and free_op as intended.
Problem seems to be that when I take the pointer to sign_op to pass to
OpenSSL, gcc does give a pointer to the function-ptr that we need, but msvc
does something else which later gets dereferenced in the provider.

In fact we had an error from msvc builds about sizeof(sign_op) not legal,
which should have been a red-flag. But we worked around it in
commit 627d1a3d28 by replacing it with sizeof(void *) --- typical
cast-away-the-bug solution.

Anyway, saying all this because I am not 100% sure that my analysis is
correct. Changing the function signature does appear to fix it though. Will
follow up with a patch.

It's a pity that we do not have a way to run unit tests on Windows builds.
I sometimes test mingw builds against some client-server setups, but msvc
builds may not be getting exercised enough --- especially with OpenSSL 3.0.

Thanks,

Selva

--000000000000117e1f05e32e61b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>As reported by Lev here:=
</div><div><a href=3D"https://github.com/OpenVPN/openvpn-gui/pull/508#issue=
comment-1174057372" target=3D"_blank">https://github.com/OpenVPN/openvpn-gu=
i/pull/508#issuecomment-1174057372</a></div><div><br></div><div>I think its=
 due to this in xkey-provider:</div><div><br></div>typedef void (XKEY_PRIVK=
EY_FREE_fn)(void *handle);<br><div>(and a similar one for SIGN_fn)</div><di=
v><br></div><div>EVP_PKEY *<br>xkey_load_generic_key(OSSL_LIB_CTX *libctx, =
void *handle, EVP_PKEY *pubkey, XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY=
_FREE_fn free_op)<br></div><div>{</div><div>...</div><div>&lt;code to pass =
&amp;sign_op and &amp;free_op to openssl&gt;=C2=A0</div><div>...</div><div>=
}</div><div><br></div><div>(see xkey_helper. around line:120, and xkey_comm=
on.h for declarations).</div><div><br></div><div>Note the lack of * before =
the sign_op and free_op variables in the function definition and declaratio=
n (not shown). The typedefs are without a * as well, but that is deliberate=
 and intentional.=C2=A0</div><div><br></div><div>This is not flagged as a b=
ug by gcc or msvc, and it seems both automatically assign function pointers=
 to sign_op and free_op as intended. Problem seems to be that when I take t=
he pointer to sign_op to pass to OpenSSL, gcc does give a pointer to the fu=
nction-ptr that we need, but msvc does something else which later gets dere=
ferenced in the provider.</div><div><br></div><div>In fact we had an error =
from msvc builds about sizeof(sign_op) not legal, which should have been a =
red-flag. But we worked around it in commit=C2=A0627d1a3d28 by replacing it=
 with sizeof(void *) --- typical cast-away-the-bug solution.</div><div><br>=
</div><div>Anyway, saying all this because I am not 100% sure that my analy=
sis is correct. Changing the function signature does appear to fix it thoug=
h. Will follow up with a patch.</div><div><br></div><div>It&#39;s a pity th=
at we do not have a way to run unit tests on Windows builds. I sometimes te=
st mingw builds against some client-server setups, but msvc builds may not =
be getting exercised enough --- especially with OpenSSL 3.0.</div><div><br>=
</div><div>Thanks,</div><div><br></div><div>Selva</div></div>

--000000000000117e1f05e32e61b9--

