References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
	<CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
	<5311bce1-b384-25d8-8c8c-89d9cbe4ff59@...515...>
	<CAHX+n4sJCs1_YLcvA_QUVd+DqRn_E0pd7fVr+2mQQqrXh3tbWQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <bd1d9c63-5d26-6ce7-59a1-f8cac5502911@...515...>
Date: Mon, 29 Aug 2016 15:30:45 +0300
MIME-Version: 1.0
In-Reply-To: <CAHX+n4sJCs1_YLcvA_QUVd+DqRn_E0pd7fVr+2mQQqrXh3tbWQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Updated build parameters to
 match openvpn-install-2.3.12-I601
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Bojan Komazec <bojan.komazec@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Il 29/08/2016 12:10, Bojan Komazec ha scritto:
> Thanks a lot Samuli.
>
> I cloned "openvpn-build" repo yesterday and created my patch branch off
> the last commit on "release/2.3" but after reading your email I checked
> it out again and saw that my "release/2.3" was actually 1 commit behind
> the origin. I am still trying to understand how this difference happened
> but yeah, my patch is not necessary.

I had made essentially the same change as you did in my local=20
"release/2.3" branch, but had forgotten to push it to the official=20
repository. I did that push after seeing your email, which probably=20
explains this.

> Regarding the contribution process, I was
> reading https://community.openvpn.net/openvpn/wiki/CodeRepositories page
> which states: "All bug fixes should be developed against the master
> branch, and where it is decided to include such fixes in a minor release
> (2.1.x, 2.2.x, etc), it will be cherry-picked from the master branch and
> into the suitable release branches.". This is what made me thinking I
> should create a patch for "master" rather than "release/2.3". Did you
> suggest using release branch as a target because my patch was not a bug
> fix (but a simple build parameter update)?

No. As David said, the CodeRepositories page is about OpenVPN core=20
mostly. I will check if the documentation there could be improved to=20
make things more clear.

The reason I think your patch should only go to "release/2.3" branch is=20
that building OpenVPN 2.3.12 with openvpn-build "master" branch makes=20
little sense due to the incompatible changes made to openvpn.nsi between=20
2.3.11 and 2.3.12.

Arguably we could add openvpnserv2 to 2.3.x, but I would rather focus on=20
getting 2.4.0 out.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

