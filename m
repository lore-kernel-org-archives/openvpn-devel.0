Message-ID: <4DA8CD5E.9080301@...1030...>
Date: Fri, 15 Apr 2011 23:57:34 +0100
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
Subject: [Openvpn-devel] route-up and iproute plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Is there a plugin allowing me to run "route-up" and "iproute" 
(replacement) scripts taking advantage of the split privilege execution?

I know there is down-root which allows a "down" script to be executed in 
this fashion, but I am not sure I could find a similar one for the above 
two scripts.

The reason I am asking this is two-fold: currently I have to install the 
sudo package, configure it and include sudo commands in the above 2 
scripts in order to avoid route/ip commands being executed in 
unprivileged environment. While this works well, I'd much rather have 
everything better organised (and more secure) within OpenVPN.

I've had a (very) quick look at down-root.c and openvpn-plugin.h files 
and it seems possible to use those as a template to write 2 additional 
plugins dealing with those two scripts, though I do not wish to reinvent 
the wheel if there are already in existence or if there is an easier way 
of doing this (if at all possible).

Many thanks in advance!

