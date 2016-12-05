References: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
	<CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>
	<ac786c37-b52a-cb6d-dc5b-31764db832d5@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <74b79533-08cf-bc58-f2a5-8c06e4a07480@...277...>
Date: Mon, 5 Dec 2016 01:06:28 +0000
MIME-Version: 1.0
In-Reply-To: <ac786c37-b52a-cb6d-dc5b-31764db832d5@...2080...>
Subject: Re: [Openvpn-devel] The windows installer and interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net



On 04/12/16 23:20, David Sommerseth wrote:
> On 04/12/16 15:42, Илья Шипицин wrote:
>>
>>
>> 2016-12-03 23:48 GMT+05:00 Selva Nair <selva.nair@...277...
>> <mailto:selva.nair@...277...>>:
>>
>>     Hi,
>>
>>     In the installer, interactive service is tied to the installation of
>>     automatic service (openvpnserv2) --- if you opt not to install
>>     openvpnserv2, interactive service is also disabled. You can install
>>     openvpnserv2 without installing the interactive service, but not the
>>     other way.
>>
>>     I think we should consider interactive service as a requirement for
>>     properly running the GUI (note that we do not set the GUI to request
>>     admin rights anymore). So I suggest:
>>
>>     1. Always install the interactive service along with openvpn core
>>     (and set up the required HKLM registry entries) OR at least
>>     automatically select interactive service if the GUI is selected.
>>
>>     I prefer the first option as that service doesn't do anything unless
>>     a client connects to its service pipe, and has some uses even
>>     without the GUI.
>>
>>     2. Make it possible to uncheck automatic service (openvpnserv2)
>>     without unchecking interactive service.
>>
>>     A vast majority of installations would need only openvpn core, the
>>     GUI and interactive service. Most users will not use the automatic
>>     service (openvpnserv2) at all. Given that the latter requires .NET
>>     4.0 which means an additional 50MB+ download for some, a very slow
>>     installation and possible restarts, forcing it on to get interactive
>>     service is not good.
>>
>>     That said we could still leave openvpnserv2 selected by default as
>>     changing that at this stage may be unwise. Hopefully many Windows
>>     users may already have .NET 4.0 or higher installed.
>>
>>
>> thank you very much for your efforts.
>>
>> however, it seems to get more and more complicated ("what if we install
>> new version after old version ... and checkboxes are set in different
>> ways...").
>>
>> what do I suggest, is to simplify things, i.e.
>>
>> 1) add "send installation statistics anonymousely" (we will see checkboxes)
>
> No.  Do not ever add such statistics.  Many OpenVPN users are privacy
> aware and they will make a lot of noise if we ever do something like this.
>
> Further do not add additional check-boxes.  Give users as few options as
> possible, presume users are stupid (and I include everyone in this
> statement, even including sys-admins and developers) and they will do
> random choices on such options based on their mood of the day.  We who
> develop OpenVPN have the best condition in most cases to recommend sane
> defaults, provide that and ignore the rest.  If we are wrong on these
> defaults, we will get to know it soon enough and can re-evaluate the
> defaults and fix it for everyone.
>
> And rather put advanced tweaks behind some more hidden command line
> switches/options for those users who truly understands these details.
>
> Seriously, just start to ponder on the success of iOS over many other
> mobile OSes.  They provide as few options as possible (but no less!).
> That is, the bare minimum to provide a simple and great user experience
> for even inexperienced users.  Yes, advanced users may hate it, but the
> majority of users love this simplicity - even technical ones.
>
>> 2) run some kind of questionary
>
> Such questionnaire will only be valuable if those who fill it out have
> the needed experience and/or understanding to give educated answers.
> For the rest it will just be a mixture of "this sounds clever", "this
> sounds cool" and "No way, I will hate that".
>
>
> Be brave, settle for some really reasonable defaults we would prefer.
> Ship it and see how it is perceived.  If there are issues, we can respin
> a new installer with modified defaults regardless of the core OpenVPN
> release schedule.
>
>
>


Did somebody order a "Galactic Battle Cruiser" ?


Deh deh deh .. etc




