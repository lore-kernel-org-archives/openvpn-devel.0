Message-ID: <4F4519E2.8000108@...1114...>
Date: Wed, 22 Feb 2012 17:37:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
	<7281371.PNMm8PBGWv@...1526...>
In-Reply-To: <7281371.PNMm8PBGWv@...1526...>
Subject: Re: [Openvpn-devel] [RFC][windows] gettimeofday()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1489...>, Alon Bar-Lev <alon.barlev@...277...>, James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/12 17:27, Heiko Hund wrote:
> On Wednesday 22 February 2012 16:12:24 Alon Bar-Lev wrote:
>> In windows there is own implementation of gettimeofday(). In the
>> past there was no gettimeofday(), so we used performance counters, 
>> then James optimize it to reduce CPU consumption.
>> 
>> Unlike in the past, mingw does provide this function these days. The
>> question is if it is good enough.
> 
> Since there's no gettimeofday() in MSVC this will break building with
> the python build system. Not sure if we're in the process of getting
> rid of it, which I would welcome, so this is just for additional
> information.

That's a valid point ... But it makes me think.  What about to put James'
old code in compat.[ch] for platforms without gettimeofday.  Would that
be an appropriate middle-road?

I too would like to see MSVC go away.  Very much.  But again, let's not
decide that without James approval for it.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9FGd0ACgkQDC186MBRfrp4SQCeKnZFdeJpLz4SCxfVmKr+Ffmv
2HYAn3/sVVgjonZ/HBh+axoXTF1s+At8
=MIxf
-----END PGP SIGNATURE-----

