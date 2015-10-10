References: <etPan.52df80ec.2901d82.13bb7@...1863...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5618CEAC.5070509@...1227...>
Date: Sat, 10 Oct 2015 10:39:08 +0200
MIME-Version: 1.0
In-Reply-To: <etPan.52df80ec.2901d82.13bb7@...1863...>
Subject: Re: [Openvpn-devel] [PATCH] Update expiry date in management event
 loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Thomas Veerman <thomas.veerman@...1862...>, openvpn-devel@lists.sourceforge.net

Am 22.01.14 um 09:27 schrieb Thomas Veerman:
> When there are events from the management console with an interval shorter
> than 1 second, the event loop never stops as it keeps resetting event_wait.
> 

ACK. It is a strange cornercase and the patch does not change behaviour
otherwise.

Arne


