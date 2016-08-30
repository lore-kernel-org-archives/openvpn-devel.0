References: <57C482E0.6080308@...1147...>
	<20160829192838.GP78279@...1296...>
	<17B2503A-3899-4E7C-B11D-4316B660CD2C@...2127...>
	<CAA1AbxKC4yjzSP79G=PQ+sgbHW+axySxnyyLfuJc+NFq1D4CXw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1f6366db-c5d1-61f3-4309-99e97a828960@...1227...>
Date: Tue, 30 Aug 2016 10:32:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAA1AbxKC4yjzSP79G=PQ+sgbHW+axySxnyyLfuJc+NFq1D4CXw@...278...>
Subject: Re: [Openvpn-devel] Time to change the default cipher?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>, Jens Neuhalfen <openvpn-devel@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 30.08.16 um 09:42 schrieb Steffan Karger:
> Hi,
>
> On 30 August 2016 at 09:01, Jens Neuhalfen <openvpn-devel@...2127...> wrote:
>>> OTOH, what we could do is: indeed *change+ the default, and add a big fat
>>> warning ("you have not specified a --cipher directive.  The default has
>>> been changed from 2.3 to 2.4, so please ensure your config matches the
>>> other end" or something like that)
>> This seems like a good idea, maybe like so?
>>
>> - A “default will change” warning on “2.3” when no chipher is selected
>> - AES-256-GCM as new default for 2.4
> Even though I'm in favour of changing the default cipher, I'm afraid
> this will break too many setups, causing users to give up on OpenVPN.
> Cipher negotiation basically updates the default to AES-256-GCM, but
> will not break connections with older clients.  Whether we should also
> change the default cipher is something I'll let the OpenVPN 'veterans'
> decide.
>
Especially a silent (only logging) change will break a lot of setup.
Someone updating their OS and suddenly OpenVPN stops working. That will
be a support nightmare.

It might be better to implement a server side/client mechansim later
that refuses clients/servers that do not renogiate to a strong cipher.

Arne

