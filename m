Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160521095424.GQ53051@...1296...>
Date: Sat, 21 May 2016 12:10:04 +0200
Message-Id: <BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

[snip]

> Generally speaking, I'm in favour of reworking t_client.sh and making
> the output more readable, etc. - it was a quick hack, and more polishing
> would be welcome.
>=20
> I'm not exactly sure about the shell constructs you use, specifically
> arrays and varaible declarations - is that posix shell, or "bash"?
>=20
> This script needs to run on all platforms we support, and that includes
> more esoteric ones like AIX and Solaris - OpenSolaris /bin/sh is a ksh93
> variant (nowadays), so if it works in ksh and dash (Debian /bin/sh), I'm=
=20
> fine=E2=80=A6
>=20
> gert

Arrays are indeed not POSIX compliant. Do we have some hard baseline=20
of systems we need our tests to run on? I have SmartOS (Solaris derivate),
I could get my hands on a Solaris VM (10 or 11, I=E2=80=99ll need to check =
with Oracles
license) for local testing.

I have virtually no experience with AIX though.

As these tests are only run on development machines I assume that we can=20
require some additional packages to be installed?

I=E2=80=99ll make sure that it works on

* Ubuntu Precise Pangolin
* Mac OS
* Solaris 11 (btw: Do we use gcc or Solaris Studio?)

Can you do a final test on AIX after I am done?

Cheers
Jens


