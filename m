Message-ID: <4BD0028F.9040307@...1114...>
Date: Thu, 22 Apr 2010 10:02:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
	<201003112141.01092.dave_br@...1278...>
	<4BCCC1ED.2030500@...1114...>
	<201004192237.51287.dave_br@...1278...>
In-Reply-To: <201004192237.51287.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/04/10 23:37, Davide Brini wrote:
> On Monday 19 April 2010, David Sommerseth wrote:
> 
>> I've done a quick test on one of my connections on Fedora 12 without any
>> resolvconf package (meaning it invokes the simple cp approach), and it
>> worked like a charm.
>>
>> Applied to bugfix2.1 and merged into allmerged.
>> Commit a9c9a89e96dc1e4e843e05ecadc4349b81606b06
> 
> Sorry, I just realized that I didn't change the sha-bang line in client.down. 
> Apologies. Fix attached.

No problem!  And thanks a lot for fixing it!  I should have caught that
one during my review as well.  I looked at "everything", but managed to
not notice this one as well.  Anyway, I gave it an ACK and it's now in
the bugfix2.1 branch.  As this is a non-critical fix, I'll delay pushing
it to allmerged until more patches comes in.  You'll find it as commit
2d9c14b435ae4083aa3f6bce803ede27cce2b6cb

For future patches, would you mind adding a little bit more descriptive
text which can be used as commit log messages.  I do write those commit
logs when I find it is needed, but adding a little bit more descriptions
of what the patch does is a nice and good habit - no matter how easy the
patch looks like ... and it makes my maintenance job a lot easier and
quicker.

I won't reject good patches due to missing commit messages, but it I'm
not picking these patches first for inclusion - as they require more
work.  So the easier the patches are for me to work with, the quicker
they go into the tree after the required review.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvQAowACgkQDC186MBRfrrhCQCfdrZTU2ilBNQ+K8FC8iDguloq
X04An0/BxnoqesB1CqCS+BzYdreb8rrh
=q4xW
-----END PGP SIGNATURE-----

