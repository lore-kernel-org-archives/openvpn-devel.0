MIME-Version: 1.0
In-Reply-To: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 21 Jun 2017 07:48:54 -0400
Message-ID: <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> The OpenVPN community project team is proud to release OpenVPN 2.4.3. It
> can be downloaded from here:
>
> <http://openvpn.net/index.php/open-source/downloads.html>

Hi. Thanks for this release.

Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
fails with:

$ gpg2 -v --verify /XXX/openvpn-2.4.3.tar.gz.asc

gpg: armor header: Version: GnuPG v1
gpg: assuming signed data in '/XXX/openvpn-2.4.3.tar.gz'
gpg: Signature made Wed Jun 21 06:19:19 2017 EDT
gpg:                using RSA key D72AF3448CC2B034
gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B01E7
gpg: using pgp trust model
gpg: BAD signature from "OpenVPN - Security Mailing List
<security@...515...>" [unknown]
gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096

The SHA256 ofopenvpn-2.4.3.tar.gz is
     84a01aa3df0c12a3552ca3baaa39d700137b5bce4b6de683fe87fb79bfa5df0b

The SHA256 of openvpn-2.4.3.tar.gz.asc is
     695afa06fcf94f9e8bd2ee63267332d14e52fe24dd58c470e42dafbea371e437

The files were downloaded from
https://openvpn.net/index.php/open-source/downloads.html at about
10:24 UCT today from the New York City area.

For reference, here is the output from verifying 2.3.17:

$ gpg2 -v --verify /Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz.asc

gpg: armor header: Version: GnuPG v1
gpg: assuming signed data in
'/Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz'
gpg: Signature made Wed Jun 21 06:18:55 2017 EDT
gpg:                using RSA key D72AF3448CC2B034
gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B01E7
gpg: using pgp trust model
gpg: Good signature from "OpenVPN - Security Mailing List
<security@...515...>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owne=
r.
Primary key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
     Subkey fingerprint: B596 06E2 D8C6 E10B 80BE  2B31 D72A F344 8CC2 B034
gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096

Any ideas or suggestions?

Thanks,

Jon Bullard

