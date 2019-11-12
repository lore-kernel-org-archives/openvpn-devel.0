References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
 <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
 <e4b61969-aac3-a5cd-6642-b65e3a9f0256@...277...>
 <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
 <AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...>
 <6b2de5c1-99b7-406f-04d5-bb9449d120b9@...277...>
 <1b342791-a3ba-9932-dc02-a616f86c3e17@...515...>
 <CAC6SzHLVL4d-PVA6NBSHL4xyoo=4pVPrrAHZqKWTFkjxa3UEug@...278...>
 <8i52hb.q0k274.rtj366-qmf@...2533...>
 <CAC6SzH+tWMmEC-n0s+p6ooukjBeqOifrD5uWF0B2gz7qe187Zw@...278...>
 <f4c7d7fc-f757-9f13-56fc-93a3145da4c4@...515...>
 <CAC6SzHKphejoK5ysyTTBEgWnSxaO36VVEZmSqh015A-vjci5uw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9A6C154@...2294...>
From: Ton van Vliet <epposan@...277...>
Message-ID: <cd8be1d0-cae0-abba-3099-b21167cae081@...277...>
Date: Tue, 12 Nov 2019 11:14:39 +0100
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10C9A6C154@...2294...>
Content-Type: multipart/alternative;
 boundary="------------20118A7EA6F17C94B98B099C"
Content-Language: en-US
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------20118A7EA6F17C94B98B099C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

For the record: Following your suggestion, I have added KB2921916 to my 
Win7 system, however,when adding another TAP device, the certificate 
chain processing Error 0x800b0109 still appears in setupapi.dev.log

Regards,
Ton.

On 11-11-19 10:22, Simon Rozman wrote:
> Hi,
>
>>> Is your computer perhaps behind in Windows updates? My hunch is that
>>> Digicert's latest root certificate is not availabe in the Windows
>>> certificate store and this causes the failure.
>>>
>>> Samuli
>>     thanks for the hint! but I don't know why uninstall/reinstall make
>> things work?
> Mind that this OpenVPN release also brings the TAP-Windows6 driver update -
> first one after some years. That's why there were no issues upgrading the
> OpenVPN in the past years.
>
> The TAP-Windows6 driver remains loaded when there are TAP adapters present.
> Even if adapters are in the "disconnected" state. This makes upgrading the
> driver a real challenge. I would suggest disabling all TAP adapters before
> attempting the upgrade. Disabling the last of the TAP adapters will cause
> Windows kernel to unload the TAP-Windows6, allowing its upgrade.
>
>>    our windows 7 update is stay at 2019-8, which is not very far behind.
>> but we do security-only update to prevent telemetry, I don't know if
>> that make difference.
>>    I will try again when windows update mess quiet down. December patch
>> is always good these years. hope it is the same this year.
> 1. Windows 7 have issues with SHA-256 signatures. In general, it works. But,
> for optimal experience you should install KB2921916 (not available via Windows
> Update). Maybe that's the reason for driver signature verification failure
> recorded in your log. Probably, this error is recorded in the log on all
> Windows 7 computers without KB2921916.
>
> 2. Mind that initial release of OpenVPN 2.4.8 is shipped using separate
> installers for Windows 7/8/8.1/Server2008R2/Server2012R2 _and_ Windows
> 10/Server2016/Server2019. Please, make sure you are using the first one on
> Windows 7. We do plan to unify the installers back to a single one in future
> releases to avoid confusion.
>
> Regards,
> Simon
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------20118A7EA6F17C94B98B099C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <tt>Hi,<br>
      <br>
      For the record: Following your suggestion, I have added KB2921916
      to my Win7 system, however,</tt><tt><tt> when adding another TAP
        device,</tt> the certificate chain processing Error 0x800b0109
      still appears in setupapi.dev.log<br>
      <br>
      Regards,<br>
      Ton.<br>
    </tt><br>
    <div class="moz-cite-prefix">On 11-11-19 10:22, Simon Rozman wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:99D61A626FDA8A4B90A270669121BE10C9A6C154@...2294...">
      <pre class="moz-quote-pre" wrap="">Hi,

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Is your computer perhaps behind in Windows updates? My hunch is that
Digicert's latest root certificate is not availabe in the Windows
certificate store and this causes the failure.

Samuli
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
   thanks for the hint! but I don't know why uninstall/reinstall make
things work?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Mind that this OpenVPN release also brings the TAP-Windows6 driver update - 
first one after some years. That's why there were no issues upgrading the 
OpenVPN in the past years.

The TAP-Windows6 driver remains loaded when there are TAP adapters present. 
Even if adapters are in the "disconnected" state. This makes upgrading the 
driver a real challenge. I would suggest disabling all TAP adapters before 
attempting the upgrade. Disabling the last of the TAP adapters will cause 
Windows kernel to unload the TAP-Windows6, allowing its upgrade.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">  our windows 7 update is stay at 2019-8, which is not very far behind.
but we do security-only update to prevent telemetry, I don't know if
that make difference.
  I will try again when windows update mess quiet down. December patch
is always good these years. hope it is the same this year.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
1. Windows 7 have issues with SHA-256 signatures. In general, it works. But, 
for optimal experience you should install KB2921916 (not available via Windows 
Update). Maybe that's the reason for driver signature verification failure 
recorded in your log. Probably, this error is recorded in the log on all 
Windows 7 computers without KB2921916.

2. Mind that initial release of OpenVPN 2.4.8 is shipped using separate 
installers for Windows 7/8/8.1/Server2008R2/Server2012R2 _and_ Windows 
10/Server2016/Server2019. Please, make sure you are using the first one on 
Windows 7. We do plan to unify the installers back to a single one in future 
releases to avoid confusion.

Regards,
Simon
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------20118A7EA6F17C94B98B099C--

