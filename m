Message-ID: <4F4D24AA.4070709@...1490...>
Date: Wed, 29 Feb 2012 08:02:02 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
Subject: [Openvpn-devel] will "--push-peer-info" enable check for "--pull"?
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi there

I was wondering if "--push-peer-info" could be used to check if the
client has enabled the "--pull" option? i.e. I'd like to be able to
REJECT clients who don't have "--pull" set - so could I use the lack of
IV_* environment variables to check for that? Obviously there are other
ways for clients to work around the consequences of "--pull" - but a
start is a start

Thanks!

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


