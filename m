Message-ID: <4B8BAC60.5060703@...1114...>
Date: Mon, 01 Mar 2010 13:00:32 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Regarding patch reviews
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
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all!

I am delighted to see that more people begin to respond to patches being
sent.  These discussions are crucially important for us and the OpenVPN
community, and even the OpenVPN company I would presume.

However, I would like you to do a minor thing when you do reviews or
comments.  If you find the patch useful and the code looks good to you,
please send an *ACK* notification in your response.  This helps me who
updates the openvpn-testing.git to know if you accept/acknowledge the
patch or not.  It gives me an indication if I should include it, or not.

For now, we need at least my acceptance + a community member to ACK a
patch to get it into the openvpn-testing.git tree.  I would like to see
patches going in, and when I see it's been ACKed by several people I can
trust this is good for inclusion without being critical to all patches
constantly.  I don't intend to be a dictator of the openvpn-testing.git
tree ;-)

And if you disagree and see the patch as useless or that it do not have
the right code quality in your eyes, please give it a clear *NACK* in
your response.  That means that you are concerned about this patch, and
I will not so easily accept the patch.  To give a NACK, you should also
give a good reason for it.  The person who sent the patch can then
consider to drop it, or to improve it and send it for review again ...
and hopefully the latter one is what will happen.

But beware, I do track those who gives ACK's in the commit log.  So if
you ACK a patch, we know who you are.  So you might get some blame if
the ACK later on turns out to be a nasty bummer ... so don't ACK too
easily ;-)

Be critical, be honest, be direct, be helpful, be respectful ... with
these values I'm sure this will work out very fine!  Don't be afraid of
giving ACKs, and if you are uncertain - just say that!  "I'm willing to
give it an ACK, if I can understand <this piece of the patch> better.".
 If you want to understand, just ask!  There a saying that says: "There
are no dumb questions, only dumb answers".  And I want to follow this
saying.

At the moment there are 2-3 persons here who have given ACKs and NACKs
so far, which is great! ... but I feel there are more competent people
who pays attention to this mailing list ... so don't be scared and give
it a chance :)  We are here to help each other, so this should not be a
task just for the "hard core" OpenVPN developers (which I'm not, btw).

After all, the advantage is that the more people getting involved, the
quicker we can get patches included, and the more discussion the better
we can make OpenVPN together!

Thank you all for your time and efforts! :)


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuLrF0ACgkQDC186MBRfroVUQCfbsxkZ/7OUFLy++2Xw18wRynu
WUcAoJfYdmbZcOL1A3UPnKG1ukLO6Cap
=CEjl
-----END PGP SIGNATURE-----

