Message-ID: <406D45C1.2030900@...196...>
From: Miika Keskinen <weeti@...196...>
MIME-Version: 1.0
Subject: [Openvpn-devel] multiple connections on one tap
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Apr  2 00:52:04 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi.

How much functionality there needs to be implemented in order to get 
multiple connections with one tap-adapter working? And then, should that 
be implemented either by implementing ethernet-switch or maybe even with 
bridging-code? Normally when talking about bridges there is limit of 256 
interfaces per bridge and I can see that as an issue.

Then again, another issue with windows version of openvpn and mostly 
it's way of resolving whether it's run as service. It would be more than 
nice to be able to call like os.popen("openvpn ....") on windows too but 
called that way it cannot get those consolethingies and doesn't like it. 
So anyone got this same problem? I think that identifying could be done 
by other means.

And sorry for my bad engrish ;)

yours.
Miika Keskinen

