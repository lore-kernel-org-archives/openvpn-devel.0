From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvsk8aif6m.fsf-monnier+inbox@...1269...>
References: <1268075941.2962.0@...1207...> <jwvfx4atsnq.fsf-monnier+inbox@...1269...>
	<1268087777.11342.1@...1207...>
Date: Mon, 08 Mar 2010 18:09:49 -0500
In-Reply-To: <1268087777.11342.1@...1207...> (Karl O. Pinc's message of "Mon, 08 Mar
	2010 16:36:17 -0600")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

>> I think if the user just starts the dhcp client on an interface
>> independently from the moment the interface goes up (or down), this 
>> is simply a misconfiguration.
> I'm not sure I understand.  Are you saying that manually starting
> a dhcp client means that the system is mis-configured because
> it's not configured to do the right thing automatically?

No, I mean if the dhcp client is started for example in the
boot scripts.


        Stefan

