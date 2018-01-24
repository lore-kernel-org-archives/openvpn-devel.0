MIME-Version: 1.0
In-Reply-To: <CAKuzo_gpcR9PrVcPWYRsa7v7sATsbj=2hQYNzaJ-hpjjk7ZeAw@...278...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
 <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
 <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>
 <f06320ac-5b89-0cdd-9ef1-eddde02b848a@...2080...>
 <CAKuzo_gpcR9PrVcPWYRsa7v7sATsbj=2hQYNzaJ-hpjjk7ZeAw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Jan 2018 17:42:34 -0500
Message-ID: <CAKuzo_jbTt8uiR33hNnyeEzJQJ3f12fmK=4SSJdw9VtoEqzZyw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Jan 22, 2018 at 12:31 PM, Selva Nair <selva.nair@...277...> wrote:
> Hi,
>
> On Mon, Jan 22, 2018 at 12:18 PM, David Sommerseth
> <openvpn@...2080...> wrote:
>> On 22/01/18 16:27, Selva Nair wrote:
>>> - Present patch: connection process appears stuck (but UI is still
>>> responsive) and logs show the daemon is waiting for signature
>>>
>>> - This proposal: connection fails with: "External EC cert/key not
>>> supported in this config. Try using --management-external-key 2"
>>> User edits the config option and the connection process appears stuck .....
>>>
>>> I suppose the latter is a bit better.
>>
>> Well, it should probably be tweaked slightly better.  First of all, if run via
>> a GUI front-end, it's the GUI which should set this argument.  We could
>> consider to add a "fail-safe" on this option, so once set - it can't be
>> changed again.  The more advanced rabbit whole fix would be that the command
>> line provided --management-external-key option overrides whatever is in the
>> configuration file; doing this will require more work though.
>
> Problem with GUI specifying the option is that it has to first check
> whether the config uses management-external-key (this option
> interferes with --key, --pkcs12 etc.). Probably not an issue with most
> UI's out there but Windows GUI doesn't currently parse the config at
> all. That said, Windows GUI doesn't support management-external-key so
> that's not a strong argument.
>
>>
>> This will make the VPN connection will still fail, but it won't be stuck any
>> more.  The user may complain "but I did add that option!?" which then is a
>> better starting point for support cases ... "Yes, it is most likely ignored as
>> your user interface is not capable of this feature".
>>
>> Another alternative is to extend an already longer error log entry, by
>> mentioning "also ensure that your management interface front-end supports
>> version 2."
>
> What about extending the current "version" command with an argument
> where the client states the version of "management-speak" that it
> supports. Current management version is 1, we increase it to 1.1 and
> unless the client says "version 1.1" or more we do not send PK_SIGN.
> The client could do that when it gets the version message or any time
> later. The response to version command (current management version and
> openvpn daemon's version stays the same). No full-fledged cap
> negotiation, but good enough.
>
> The UX would be much better that way.

I would appreciate some feedback.

Thanks,

Selva

