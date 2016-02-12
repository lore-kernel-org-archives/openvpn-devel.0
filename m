References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...> <20160212131529.GQ24952@...1296...>
	<CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
	<20160212143742.GV24952@...1296...>
	<CAKuzo_jYw4UrAg4FR5EtEzp+9QDviEdFjegnWtBqCBdsQQA06w@...278...>
	<20160212151544.GW24952@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56BDF828.4010902@...1227...>
Date: Fri, 12 Feb 2016 16:20:08 +0100
MIME-Version: 1.0
In-Reply-To: <20160212151544.GW24952@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
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
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 12.02.16 um 16:15 schrieb Gert Doering:
> Hi,
>
> On Fri, Feb 12, 2016 at 09:56:15AM -0500, Selva Nair wrote:
>>>> This is tricky..First, if the config is not readable, log file is not set
>>>> at that time and log goes to stdout (mapped to "/dev/null" by the GUI).
>>>> Even otherwise  parsing the log to figure out what went wrong is not
>>> always
>>>> an easy task for a program.
>>> I'm not sure this description is fully correct - doesn't the GUI (via
>>> service) pass the log file before --config with the remaining options?
>> No, currently --config goes first.
> Which we might want to turn around, then (changes user-visible behaviour
> in case the config file has a "log mylog.txt" line)...
>
> Anyway, I don't want to be actually the one who solves that, I'm just
> a user who tends to run into user-unfriendliness all the time :-)
>
>
You are too negative:

Changelog:

- Now honours user defined log file location

Arne

