Message-ID: <515AE151.5030900@...1227...>
Date: Tue, 02 Apr 2013 15:46:57 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
	<20130401184834.GE428@...1296...>
	<CAEsd45RkiWG0F9st=s-SE0SW428yE-bEFL6WBMJBgXHTjYwXQA@...278...>
In-Reply-To: <CAEsd45RkiWG0F9st=s-SE0SW428yE-bEFL6WBMJBgXHTjYwXQA@...278...>
Subject: Re: [Openvpn-devel] building on OSX (for Tunnelblick)
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Harold Molina-Bulla <h.molina@...277...>


>
> Tunnelblick is still being built on OS X 10.6.8 with Xcode 3.2.2
> because it still supports PowerPC, which later versions of Xcode
> (which are required for use on 10.7+) don't support.
Is there a specific reason for Xcode 3.2.2? I set up a 10.6.8 snow
leopard with 3.2.2 and did not have net/if_utun.h. However Xcode 3.2.6
includes net/if_utun.h and utun works on the test machine (and also
include the powerpc-* gcc binaries)

Arne

