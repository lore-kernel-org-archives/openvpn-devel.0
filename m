Message-ID: <4B8645F2.9060703@...1299...>
Date: Thu, 25 Feb 2010 22:42:10 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <4B835120.60705@...1299...>	<COL110-W60C40CD4E9F200271ADA2DA2410@...512...>
	<4B863E95.5030405@...1299...>
In-Reply-To: <4B863E95.5030405@...1299...>
Subject: Re: [Openvpn-devel] [Openvpn-users] how to disable firewall for
 openvpn interface under	Vista/Win7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

I've discovered another issue - but found a fix.

Apparently Windows7 cannot identify what kind of link an openvpn TAP
interface is, and marks it as "Unidentified network", and it couldn't be
reclassified. As such it always gets pushed into the "public" profile,
which means firewall-up/etc.

I found this article to do with this happening for other network
interfaces - with a regedit hack fix

http://social.technet.microsoft.com/Forums/en-US/w7itpronetworking/thread/e404cb1f-4f60-4d00-abaa-3b2e61415652

that enables Win7 to be able to recheck that interface and when I
created the key and restarted openvpn, Win7 recategorized the interface
as "domain" - which is exactly right!

Shouldn't openvpn ensure it sets the same registry keys during install -
so that this always happens?

Thanks

Jason

On 02/25/2010 10:10 PM, Jason Haar wrote:
> Thanks Leonard - your instructions were spot-on. However, I need to find
> out how to do the same thing using netsh as I want to add it to the "up"
> script on the clients - so that no matter what the user renames their
> openvpn interface to, it will always have the firewall disabled (also
> expecting users - even IS helpdesk - to manage 4-6 gui clicks without
> ever getting it wrong is too much to ask).
>
> Now that I know it can be done, I only need to find out how to do it
> using netsh - half way there!
>
> Thanks again, I'll post my results back if/when I figure it out
>
> Jason
>
> On 02/25/2010 05:39 AM, Leonard Parker wrote:
>   
>> Hello Jason,
>>
>> It's entirely possible to do per-interface disabling of the Firewall
>> in Win7, I haven't attempted this by the NETSH command line as yet,
>> but there is a fairly powerful GUI for firewall control, if not a
>> little difficult to navigate at first.
>>
>> So Control Panel > Windows Firewall > (Sidebar) Advanced Settings
>>
>> Now that we have the "Windows Firewall with Advanced Security" window
>> open, click on the "Windows Firewall Properties" Hyperlink.
>>
>> Now with the Properties dialog open you'll notice the tabs are "Domain
>> Profile" "Private Profile" "Public Profile" and "IPSec Settings"
>>
>> In each of the first three profile tabs you'll want to do as follows:
>>
>> Locate the "Customize" Button next to the line "Protected network
>> connections:"
>>
>> in the "Customize" Dialog you will find a list of your Network
>> Interfaces with a series of check boxes. Take the Checkbox out of your
>> Tap adapter's connection and press OK.
>>
>> You're set.
>>
>> I haven't failed! I've only found 10,000 ways that don't work.
>>
>>
>>
>>     
>>> Date: Tue, 23 Feb 2010 16:53:04 +1300
>>> From: Jason.Haar@...1299...
>>> To: openvpn-users@lists.sourceforge.net
>>> Subject: [Openvpn-users] how to disable firewall for openvpn
>>>       
>> interface under Vista/Win7
>>     
>>> Hi there
>>>
>>> In our trials of Openvpn under XP, we've managed to reconfigure the
>>> firewall to disable itself on just the openvpn TAP interface via:
>>>
>>> echo firewall set opmode mode = DISABLE interface = %dev% | netsh
>>>
>>> This is great: it means an XP box on the Internet (eg hotel) has its
>>> firewall up, but any incoming traffic on the openvpn interface is
>>> accepted: which means helpdesk, vulnerability scanners, etc still have
>>> full access to the XP box. Happiness abounds :-)
>>>
>>> However, I cannot manage it under Vista+ (actually Win7). For one thing
>>> "netsh firewall" is depreciated (it's now "advfirewall"), and there
>>> isn't an "interface" option any more - it's now "interfacetype" and that
>>> means "lan", "wireless", "ras". I really wonder what kinds of... people
>>> they hire at Microsoft... A more tin-hat impression is that they are
>>> deliberately trying to break third-party VPNs...
>>>
>>> So I had a splendid situation under XP and would like to do the same
>>> under Win7. Any ideas? To recap: I want the firewall to remain up - but
>>> down for just the OpenVPN interface.
>>>
>>> Thanks!
>>>
>>> --
>>> Cheers
>>>
>>> Jason Haar
>>> Information Security Manager, Trimble Navigation Ltd.
>>> Phone: +64 3 9635 377 Fax: +64 3 9635 417
>>> PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1
>>>
>>>
>>>
>>>       
>> ------------------------------------------------------------------------------
>>     
>>> Download Intel&#174; Parallel Studio Eval
>>> Try the new software tools for yourself. Speed compiling, find bugs
>>> proactively, and fine-tune applications for parallel performance.
>>> See why Intel Parallel Studio got high marks during beta.
>>> http://p.sf.net/sfu/intel-sw-dev
>>> _______________________________________________
>>> Openvpn-users mailing list
>>> Openvpn-users@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>>>       
>
>   


-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


