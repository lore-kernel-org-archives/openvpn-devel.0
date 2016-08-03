References: <57A078C9.6030309@...277...>
	<20160802112242.GW78279@...1296...> <57A0954A.804@...277...>
	<57A0BE14.3080809@...277...> <20160802165900.GY78279@...1296...>
	<57A0EE6F.4080905@...277...>
	<CAKuzo_iq4x2gyCzaeQS7Z2cShzCfRr4Qz4wAce=DfYhmUH4OtQ@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <57A1FC83.8050200@...277...>
Date: Wed, 3 Aug 2016 15:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iq4x2gyCzaeQS7Z2cShzCfRr4Qz4wAce=DfYhmUH4OtQ@...278...>
Subject: Re: [Openvpn-devel] Auto-create Windows Firewall Rule
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 03/08/16 02:03, Selva Nair wrote:
> On Tue, Aug 2, 2016 at 3:03 PM, debbie10t <debbie10t@...277...> wrote:
>
>> On 02/08/16 17:59, Gert Doering wrote:
>>> Hi,
>>>
>>> On Tue, Aug 02, 2016 at 04:36:52PM +0100, debbie10t wrote:
>>>> Win10pro OVPN Server - Openvpn snapshot version
>>>> 2.3_git-I601 20160518 refs/heads/master/0d8a4ffa2293dda8
>>>>
>>>> Mixture of clients IPv4+6 wxp/w7/w10/various linux
>>>>
>>>> IPv4 & IPv6 All works well!
>>> Cool.  Thanks :-)
>>>
>>> (That snapshot is getting a bit old in the tooth, tho...)
>>>
>> It was not my first concern, however ..
>>
>> Uninstalled that version and installed this version:
>> openvpn-install-release-2.3-20160726162312-d1c08ab136-x86_64.exe
>> (Including TAP removal/Reinstall win10)
>>
>> All went well, the full un/re-install completed
>> before some IRC sessions even timed-out ! Outstanding :-)
>>
>> Also, testing using the GUI + new Interactive service
>> (tho normally I would use the old service or nssm)
>
> Could you also test running a server using the interactive service (i.e.,
> without any admin rights)? Currently the only easy way to do this is to
> start a server config using the GUI. The server will get killed when the
> GUI exits but good enough for testing.
>
> I am interested in writing a launcher that uses the interactive service for
> such needs. Although, in theory, it should just work, running the server
> this way has hardly been tested.
>
This will take me some time to customise the build system .. it always does.
If Somebody (Samuli perhaps) could build a snapshot of gitmaster for Wx86_64
with TAP and new interactive service I will test it as thoroughly as I can.

Thanks


