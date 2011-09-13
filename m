Date: Tue, 13 Sep 2011 11:41:11 +0200
From: "Krashan Brahmanjara" <krokodylowy3@...1498...>
Message-ID: <4e6f25371d6bd0.07599718@...1498...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/3] better --auto-proxy support for
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@...647...

>On Wednesday 17 August 2011 16:07:42 Alon Bar-Lev wrote:
>> How do you configure Internet Explorer proxy detection for local system
>> account? Or... alternatively you need to create a user for openvpn
>> service, login, execute IE, set whatever.
>> Quite difficult for unattended setup.
>> Well, maybe find places in registry where IE stores the settings...

>I don't think that's a problem. If no IE proxy configuration can be fetched, 
>the default config set with proxycfg will be used. And besides that there's 
>still the option to manually configure proxy settings in openvpn directly for 
>such setups.

>Heiko

At this moment main problem is invalid proxy search sequence.
I'm in network with high protection policy. Proxy got password and IE settings are available but password is not visible. Only proxycfg data are visible and Firefox problablu use them with success.

So in auto-proxy mode proxycfg setting should be checked before IE settings. 





