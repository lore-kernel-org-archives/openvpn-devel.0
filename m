Message-ID: <54F4BFE0.1000904@...1490...>
Date: Tue, 3 Mar 2015 08:54:08 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
Subject: [Openvpn-devel] server support for UV_ variables still not present
	in 2.3.6?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there

Back in Aug 2014, I needed the server to support exporting the UV_*
variables the client sets into external programs the server calls on
client-connect, so was told to try out openvpn-2.3_git - which had that
missing code. So I did a clone of that and off I went

I've been happily running on that for some time now - but just tried out
2.3.6 - and discovered that support still wasn't in there!

Was it dropped for some reason, or was/is 2.3_git not a true
representation of what ended up in the official 2.3 series? The missing
code was in src/openvpn/misc.c

Thanks

-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


