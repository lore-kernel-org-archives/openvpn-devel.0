Message-ID: <4C3C390B.2020202@...1114...>
Date: Tue, 13 Jul 2010 11:59:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C3C2CDA.60409@...1299...>
In-Reply-To: <4C3C2CDA.60409@...1299...>
Subject: Re: [Openvpn-devel] bug stopping the use of mssfix/fragment in
 udp+tcp configs?
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/07/10 11:07, Jason Haar wrote:
> Hi there
> 
> I have just looked at the current 2.2 git code and the bug blocking the
> use of udp+tcp combination configs when you want to use mssfix/fragment 
> is still present. See
> https://community.openvpn.net/openvpn/wiki/Topics-2010-04-22 for
> references.
> 
> By that I mean I cannot use fragment/mssfix even within a udp
> "<connection>" profile - as the tcp profiles that follow trigger openvpn
> to error.
> 
> Is that planned to be fixed? With it, an openvpn config can contain udp,
> tcp and tcp-via-auto-proxy "<connection>" profiles - leading to the best
> opportunity for openvpn "escaping" from almost any network imaginable -
> without user intervention.
> 

Hi Jason!

Thank you for bringing this up again!  It most definitely have fallen
out of our radar for a little while again.  I'll make sure to put this
into a Trac ticket so that we won't forget it so easily again.

Having that said, this feature change will most probably not hit the 2.2
release *unless* somebody is able to bring in a patch to the mailing
list soon enough to get it reviewed and accepted into the -testing tree.
 We've just recently put together the beta2.2 branch (and I will need to
redo the branch once more, unfortunately) so _no doors are closed yet_.
 But I really hope we can reach an release candidate long before the end
of this year, this is the point were we most probably will put a strict
feature change policy.

You might be worried that this fix might not come before 2.3, and be
even more worried when that release will come.  I can assure you that I
will work hard for getting the release process going quicker *without*
jeopardising the stability OpenVPN does have.

OpenVPN is one of those few remarkable pieces of software where not
everything might work as expected - but despite that, OpenVPN is really
rock solid and reliable.  This is not something we can or will
sacrifice.  Stability is our primary goal.

But after all ... *We can use your help* ... So whom ever have
possibility to write some code, review code, test our -testing tree ...
*Please* raise your hand on the mailinglist or join the #openvpn-devel
meetings[1] and tell us how you would like help out!  With even more
participation from even more people, we can get the release cycle going
smoother - and hopefully much quicker.


kind regards,

David Sommerseth


[1] <https://community.openvpn.net/openvpn/wiki/IrcMeetings>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkw8OQYACgkQDC186MBRfrqrywCfSpXsMXyTQjuHBMNMdtiTxR6X
jp4AnjSItLWj/7Y5Q4OPjEVX3eYBN8Kp
=bS4a
-----END PGP SIGNATURE-----

