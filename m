References: <57A078C9.6030309@...277...>
	<20160802112242.GW78279@...1296...> <57A0954A.804@...277...>
	<57A0BE14.3080809@...277...> <20160802165900.GY78279@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <57A0EE6F.4080905@...277...>
Date: Tue, 2 Aug 2016 20:03:11 +0100
MIME-Version: 1.0
In-Reply-To: <20160802165900.GY78279@...1296...>
Subject: Re: [Openvpn-devel] Auto-create Windows Firewall Rule
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 02/08/16 17:59, Gert Doering wrote:
> Hi,
>
> On Tue, Aug 02, 2016 at 04:36:52PM +0100, debbie10t wrote:
>> Win10pro OVPN Server - Openvpn snapshot version
>> 2.3_git-I601 20160518 refs/heads/master/0d8a4ffa2293dda8
>>
>> Mixture of clients IPv4+6 wxp/w7/w10/various linux
>>
>> IPv4 & IPv6 All works well!
> Cool.  Thanks :-)
>
> (That snapshot is getting a bit old in the tooth, tho...)
>
It was not my first concern, however ..

Uninstalled that version and installed this version:
openvpn-install-release-2.3-20160726162312-d1c08ab136-x86_64.exe
(Including TAP removal/Reinstall win10)

All went well, the full un/re-install completed
before some IRC sessions even timed-out ! Outstanding :-)

Also, testing using the GUI + new Interactive service
(tho normally I would use the old service or nssm)

This VPN can now run 24/7, so it can run other tests:
eg large data xfer (backups), --float etc.
(and test my disaster recovery .. pulling out the power
*gulp* .. but I believe it is all set to go)

Anyway, OpenVPN seems to function near perfectly.
(at least, I cannot find issue so far)

Have not tried --ncp-cipher, --cipher none or --pull-filter
yet, but I can set up some tests for that soon enough.

Looks very promising
Thanks and Regards



