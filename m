MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=_d23d12d5a17a40a64ba7d58258ea2ff2"
From: pbarton@...1924...
In-Reply-To: <20160708172423.GO78279@...1296...>
Date: Fri, 08 Jul 2016 10:58:00 -0700
Message-Id: <20160708105800.26b81b44f7069d75256c531b0c1ba101.f675a977f7.mailapi@...2149...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Segmentation Fault
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

--=_d23d12d5a17a40a64ba7d58258ea2ff2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=20
 It seems to mostly replace all "md5_..." stuff with "sha1_..." functions
 (looks very much like find-and-replace to me...) *and* it adds a special
 fips function call that allows MD5 in certain circumstances...

 + /* FIPS 140-2 explicitly allows MD5 for the use in PRF although it is not
 + * to be used anywhere else */
 + if(kt =3D=3D EVP_md5() && prf_use)
 + HMAC_CTX_set_flags(ctx, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);


 The main usage we have for md5 is the PUSH_OPTION hash comparison - which=
=20
 is really not a "crypto" thing, just a "hash that is around to be used",
 and it's a local thing - so changing that all to sha1_* will not harm
 interoperability.

 gert


=20
=20
 I browsed through the opensuse patch and it appeared to match up with the =
source files for openvpn 2.3.11 so I applied the patch.  I am now successfu=
lly connecting the tunnel in FIPS MODE!!
=20
Thanks for the assistance!
=20
Peter

--=_d23d12d5a17a40a64ba7d58258ea2ff2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"threadBlockQuote" style=3D"border-left: 2px solid #C2C=
2C2; padding-left: 3px; margin-left: 4px;">
<div><br /> It seems to mostly replace all "md5_..." stuff with "sha1_..." =
functions<br /> (looks very much like find-and-replace to me...) *and* it a=
dds a special<br /> fips function call that allows MD5 in certain circumsta=
nces...<br /><br /> + /* FIPS 140-2 explicitly allows MD5 for the use in PR=
F although it is not<br /> + * to be used anywhere else */<br /> + if(kt =
=3D=3D EVP_md5() &amp;&amp; prf_use)<br /> + HMAC_CTX_set_flags(ctx, EVP_MD=
_CTX_FLAG_NON_FIPS_ALLOW);<br /><br /><br /> The main usage we have for md5=
 is the PUSH_OPTION hash comparison - which <br /> is really not a "crypto"=
 thing, just a "hash that is around to be used",<br /> and it's a local thi=
ng - so changing that all to sha1_* will not harm<br /> interoperability.<b=
r /><br /> gert<br /><br /></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</blockquote>
<div>I browsed through the opensuse patch and it appeared to match up with =
the source files for openvpn 2.3.11 so I applied the patch. &nbsp;I am now =
successfully connecting the tunnel in FIPS MODE!!</div>
<div>&nbsp;</div>
<div>Thanks for the assistance!</div>
<div>&nbsp;</div>
<div>Peter</div>

--=_d23d12d5a17a40a64ba7d58258ea2ff2--

