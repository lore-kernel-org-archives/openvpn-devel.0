Message-ID: <5031513E.6010004@...1227...>
Date: Sun, 19 Aug 2012 22:49:02 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAHFjfK73YDrEUYL0fi7_8pu=v3W3F-sp=Hty3Un1hyJm=T_79g@...278...>
	<20120819100739.GW18296@...1296...>
In-Reply-To: <20120819100739.GW18296@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3 alpha - configfile with static
 keyfile does not work!
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 19.08.2012 12:07, Gert Doering wrote:
> Hi,
>
> On Sat, Aug 18, 2012 at 11:21:32PM +0200, Markus Ferlitsch wrote:
>> Now with OpenvPN 2.3 alpha the TLS configfile works fine (none error in logfile)
>> Bu the config-file with only static secret-file doesn't connect - it's
>> a bug in alpha I think.
> It's somewhat easier to figure out what's going wrong if we can *see* your
> config file...
>
> My crystal ball is cloudy today.

My crystal ball says it is the windows gui which always adds --tls-exit 
to command line options.

Arne

