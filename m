Date: Fri, 16 Mar 2018 17:45:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180316164554.GI69387@...1296...>
References: <20180316164059.9120-1-xiaoningning@...109...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2ibbZKN8N91xLJga"
Content-Disposition: inline
In-Reply-To: <20180316164059.9120-1-xiaoningning@...109...>
Subject: Re: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ning Wei <xiaoningning@...109...>
Cc: openvpn-devel@lists.sourceforge.net

--2ibbZKN8N91xLJga
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 16, 2018 at 09:40:59AM -0700, Ning Wei via Openvpn-devel wrote:
> Increase TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with
> ENABLE_PKCS11, the password field can be 4096.  The old size of
> TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.

Please do not keep re-sending this patch just because you did not get
a response right away.  This messes up our patch tracking in patchwork,
and annoys those that will eventually find time to review it.

Such a change might cause incompatibilities or overflows in unexpected
ways, so a review is complex and not just anyone can do it - and those
few that understand the openvpn protocol <-> tls interaction well=20
enough are quite busy with other work.

So, patience please.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--2ibbZKN8N91xLJga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaq/TBAAoJEB2Cnv7KVigSORIL/ijZ89/v6U2cy141Jhm90N7Z
Ez7RcbRw29Boaqxz9cjCTHHV541yvwlrcRfCG+tCc65ljI+7sAjtRlFx3Xa7Ww6f
Bmh6CJFQB4UNaVy99CY7M1DCGZ3JT3nPF9wEHl5IXRsUisMVQA9hbtlj6AOaS//J
FMgkfWiXdVMOzeA12qcZy/X/WZgL3X7FAlFXGaPhXGCtkK9F25Kzt94ZtlEYKrkR
3Ju/nvrcPU66D+KbjSTMmb2ZRRO4ocTD204GGym5pk4FvMdOAfznZpYtnmKa2myx
H0HJvEqY+vZWP4WS+d0DP3cT9rjkk7ghs3LHQuMhkT/uFIIEDugIKCRIQmZ8YFYV
TNIrgDJnO45yagD264BZNJwQLjeuFliwc++QCZDQeftPGhQul4ZJFLjg/PdGnII1
XZcI/5qyJ+NGTCUwusWVsrIEy9QpitxiUrLQE9IPHJo/+sJZkmL+gCy7IKdq4AjC
l96duFqNubsH9Xb5fB+iSZlTk4Vv1MERli/uIJ+kCQ==
=yX8J
-----END PGP SIGNATURE-----

--2ibbZKN8N91xLJga--

