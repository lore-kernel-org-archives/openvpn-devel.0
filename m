Message-ID: <50364F38.9040008@...1114...>
Date: Thu, 23 Aug 2012 17:41:44 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345727389.42365.YahooMailNeo@...1744...>
	<3026659.dQ0z7Nl7Cc@...1745...>
	<1345733114.69457.YahooMailNeo@...1747...>
	<4D629B87-3EE4-471D-8A58-4C8D28EE2C2E@...1286...>
	<1345735851.47115.YahooMailNeo@...1744...>
In-Reply-To: <1345735851.47115.YahooMailNeo@...1744...>
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
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
To: Amm Vpn <ammdispose-vpn@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/08/12 17:30, Amm Vpn wrote:
> 
> Currently openvpn BLINDLY runs any script which in my opinion is
> too dangerous. One breach and intruder can simply erase your whole
> harddisk.

Agreed.

> My idea of script-dir is taken from sendmail concept of smrsh. 
> http://www.faqs.org/docs/securing/chap22sec182.html
> 
> In my case person does not have direct access to machine. But only
> to config file. Now if I make sure that he cant change script-dir,
> it secures my whole machine.
> 
> Otherwise there is noway I can give access to config file to him
> without worrying about him running "rm -rf /"
> 
> Hope I am able to convey my idea. Just trying to patch a flaw in
> openvpn, in my opinion

But you forget one detail.  OpenVPN options can be overridden by just
appending an extra --script-dir at the command line, due to the nature
of the option parser.  Which is the same situation for
- --script-security as well.  Your patch has the same flaw as
- --script-security.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlA2TzgACgkQDC186MBRfrrWwgCeOHVUDUWVfSPVoFSSet1BlBU8
fQMAn0Pw9ia3cKkW1wXe3R65brcjHmIV
=ZBlP
-----END PGP SIGNATURE-----

