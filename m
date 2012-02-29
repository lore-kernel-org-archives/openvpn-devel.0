Message-ID: <4F4E3DD1.3010308@...1030...>
Date: Wed, 29 Feb 2012 15:01:37 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <4F4D019B.2090704@...1030...>
	<4F4D08EF.6040404@...1114...>
In-Reply-To: <4F4D08EF.6040404@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 released
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> For the plug-in API ... look at openvpn-plugin.h ... look for
> openvpn_plugin_*_v3.  Especially openvpn_plugin_open_v3() and
> openvpn_plugin_func_v3().  If fact, most of the openvpn-plugin.h is a
> pretty comprehensive reference for the plugin API.  For a working
> example, look at plugin/examples/log_v3.c.
>
> For the --client-nat ... look at the man new page.
> <http://openvpn.net/index.php/manuals/523-openvpn-23.html>
>   
Thanks, I'll have a look later on today. Does this differ from the "old" 
plugin mechanism in v2.2?


