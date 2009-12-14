Message-ID: <4B2637E7.2020307@...1114...>
Date: Mon, 14 Dec 2009 14:04:39 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1260552743.31755.0@...1207...>	<4B22D2C8.5020703@...41...>	<jwv8wd8g722.fsf-monnier+inbox@...1269...>	<4B23808D.40907@...515...>
	<4B2407CE.6070301@...1114...> <4B2634F2.6020405@...515...>
In-Reply-To: <4B2634F2.6020405@...515...>
Subject: Re: [Openvpn-devel] OpenVPN project organization
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/12/09 13:52, Samuli Seppänen wrote:
> I can't see any reason why the test scripts should be secret. So better
> have them in the open. 

I completely agree!  That's the very best approach!

> Do you think it'd be possible to have a
> distributed network of hosts in the inventory? I'm sure there are tons
> of people with extra server resources who could contribute by providing
> test hosts. Or is the technology dependent on hosts being in the same
> physical LAN? If not, we could use, say, IPSec to connect the boxes
> safely together (just kidding :)... OpenVPN makes more sense in our
> context).

That's a very good question, actually :)  I don't believe it's needed
for these boxes to be on the same network at all.  But it will be some
communication between the scheduler, inventory and the test boxes.
Each local site might need to have a local inventory, I'm not sure how
that really works.

Anyway it must exist some kind of serial port console which is
accessible over the network somehow as well.  But I believe the IPMI SOL
access can be used in most cases, for the hardware which supports that
... Remember that the box is scratch installed on each test run, to
provide a predictable testing environment.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksmN+QACgkQDC186MBRfrqbuQCgrS0L2vRxvjW/sEASuB7d1ak4
Pw4AoJAghuewPSgI5UIUzsTmANzUnonT
=/EGN
-----END PGP SIGNATURE-----

