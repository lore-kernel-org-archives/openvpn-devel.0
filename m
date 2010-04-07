Message-ID: <4BBCF086.2060005@...1147...>
Date: Wed, 07 Apr 2010 22:52:22 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>	<201004070959.09215.hhund@...194...>	<OF83959B35.6804C8B1-ONC12576FE.0041E6AD-C12576FE.00424FE8@...1343...>	<201004071526.06006.hhund@...194...>
	<OF815ED8F1.B831009E-ONC12576FE.0049FAB0-C12576FE.004A9529@...1343...>
In-Reply-To: <OF815ED8F1.B831009E-ONC12576FE.0049FAB0-C12576FE.004A9529@...1343...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
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
To: Johan Ymerson <johan.ymerson@...1342...>
Cc: openvpn-devel@lists.sourceforge.net

Johan Ymerson wrote:
> Heiko Hund <hhund@...194...> wrote on 2010-04-07 15:26:05:
>   
>>> Then I don't think we see the same problem. We have been using 2.0.9 on
>>> ~100 machines for a couple of years now without these problems. We
>>> upgraded 3 of them to 2.1.1, and they all instantly got this problem. We
>>> downgraded them to 2.0.9, and all problems gone. Then started switching
>>> between 2.0.9 and 2.1_rcX to determine when this problem started, but all
>>> 2.1_rcX seems to suffer from it, but 2.0.9 does _not_! So something must
>>> have changed between 2.0.9 and 2.1 that at least makes this a lot worse.
>>>       
>> Strange, we tested with 2.1_rc22 and the driver from 2.0.9 and ran into the
>> problem within ten attempts. I can't image that the problem is related to
>> userspace openvpn. Do you have the problem every time you connect and do you
>> see the DNS servers in the output of `ipconfig /all`?
>>     
>
> I have not tested with 2.1.1 and tap driver from 2.0.9. Vanilla 2.0.9 does not have this problem (at least not in the thousands of connect attempts I have made by now). Vanilla 2.1.1 (and all rc versions I have found) does have the problem. It shows up in 1-2 attempts.
>
> `ipconfig /all` shows all the correct values.
> And, this is funny, nslookup always work.
>
>   
what exactly do you mean with 'nslookup always works' ?
> I bet this actually is a change in the behavior of the userspace part, not the driver. Something userspace did after configuring the interface, but it doesn't do anymore. Something that made Windows re-examine the DNS order.
>   
this could be a timing issue, which could be caused by changes to the 
userspace openvpn part; did you try playing with the
  route-delay
  tap-sleep
  dhcp-renew
flags ? did that have any affect?

cheers,

JJK


