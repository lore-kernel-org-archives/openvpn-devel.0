Message-ID: <4F43D9B0.6010900@...1114...>
Date: Tue, 21 Feb 2012 18:51:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
	<CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
In-Reply-To: <CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 17:12, Alon Bar-Lev wrote:
> On Tue, Feb 21, 2012 at 5:56 PM, David Sommerseth 
> <openvpn.list@...1114...> wrote:
>> There might be similar restrictions related to autoconf/automake
>> tools too.  As James has some automation for the Access Server
>> builds for those supported platforms, we must be sure we don't break
>> that for him.  From what I see, on a recent 5.7 box ...
> 
> No there is none. Unlike other dependencies autotools dependencies are
> of development machine. You should create tarball on newer machine
> then compile it on the target platform. Target platform may not have
> autotools installed at all.
> 
> The new build system will support >=autoconf-2.60, automake>=1.10,
> libtool>=2.2

That is not how James does his builds, from what I've understood.  He
does builds in his own compile farm straight from source repositories.
James might just as well pop up NACKing things if these changes breaks
his tool chain.  To put is simple: We are not allowed to break his
environments.

On the RHEL5.7 base, libtool-1.5.22 is the base version.

> Again, from experience generating tarball using these versions tends 
> to work well on very old platforms.

That's good, which can solve RHEL4 issues in a nice way.  But I expect
James to do plenty of RHEL5 builds in the future, so there is noway we
are allowed to break this.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9D2a4ACgkQDC186MBRfrr4RQCdFid58/1E8SEDyAs7QQvoo83q
KrkAn0KXXd5WRDJFeUnPa+iG1aIuH0CC
=uw9T
-----END PGP SIGNATURE-----

