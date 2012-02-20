Message-ID: <4F427532.3010407@...1114...>
Date: Mon, 20 Feb 2012 17:30:42 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CANvbpLQcUnRtvSphye1HtbS7MN2_jcHq-H6ie0gKYddE=fskYw@...278...>
	<1468878.kvAGE5Ci2b@...1526...>
In-Reply-To: <1468878.kvAGE5Ci2b@...1526...>
Subject: Re: [Openvpn-devel] Better use ip -batch on adding/removing server
 pushed routes on Linux
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/02/12 17:15, Heiko Hund wrote:
> On Monday 20 February 2012 16:00:37 Yang Zhe wrote:
>> It's quite slow to add thousands of routes via execve thousands
>> times. It's better writing the parameters to a pipe to `ip -batch -`
>> on linux.
> 
> I would even go as far as saying that it would make sense to get rid
> of the forking completely and use rtnetlink directly for this. Has
> this already been discussed here?

I agree.  It hasn't been discussed in depth, but it has been mentioned.
And if I would have had some time available, I would have looked into it
directly.  Using capabilities in Linux, it should even be possible for a
non-root process to even modify the routing table.  (it would have to be
started as root, though, but after dropping privileges)


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9CdTAACgkQDC186MBRfrqRZwCfZ1YbL52vJuw/aG+sdiCCHOdC
MCwAoK/zPwIh9rq2hiSZyN2gyeXiJhUj
=41JO
-----END PGP SIGNATURE-----

