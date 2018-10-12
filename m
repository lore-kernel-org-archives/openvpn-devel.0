MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Oct 2018 12:24:29 -0400
Message-ID: <CAKuzo_iSUX0h25O36dfZCuhRM_OCNvJttgQiM2WBGwLQnhO=xA@...278...>
Content-Type: multipart/alternative; boundary="000000000000bfc67d05780a8609"
Subject: [Openvpn-devel] rsa signature with PSS padding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000bfc67d05780a8609
Content-Type: text/plain; charset="UTF-8"

Hi,

My testing shows that OpenSSL 1.1.1 likes to use PSS even for TLS 1.2, so,
even in the short-term, this can't be worked around by just disabling TLS
1.3.

Now, for cryptoapicert, it would have been easy to support PSS using
Windows CNG API provided OpenSSL passes the hash and ask to sign with PSS
padding. But it doesn't. Instead, it adds the padding and ask us to sign
that padded data as is (i.e. padding none). In fact rsa_sign() callback is
not even called when padding is PSS -- it just jumps to rsa_priv_enc
callback. As far as I can see signing pre-padded hash is not supported by
CNG (does it?).

Any suggestions on what do we do?

Thanks,

Selva

--000000000000bfc67d05780a8609
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div><div>My testing shows that OpenSSL 1=
.1.1 likes to use PSS even for TLS 1.2, so, even in the short-term, this ca=
n&#39;t be worked around by just disabling TLS 1.3.<br><br></div><div>Now, =
for cryptoapicert, it would have been easy to support PSS using Windows CNG=
 API provided OpenSSL passes the hash and ask to sign with PSS padding. But=
 it doesn&#39;t. Instead, it adds the padding and ask us to sign that padde=
d data as is (i.e. padding none). In fact rsa_sign() callback is not even c=
alled when padding is PSS -- it just jumps to rsa_priv_enc callback. As far=
 as I can see signing pre-padded hash is not supported by CNG (does it?).<b=
r></div><div><br>Any suggestions on what do we do?</div><div><br>Thanks,<br=
><br>Selva<br></div></div>

--000000000000bfc67d05780a8609--

