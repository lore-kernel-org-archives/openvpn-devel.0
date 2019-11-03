References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
 <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
 <e4b61969-aac3-a5cd-6642-b65e3a9f0256@...277...>
 <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
From: Ton van Vliet <epposan@...277...>
Message-ID: <79bb28f9-05bb-44b7-874b-b228b42330ec@...277...>
Date: Sun, 3 Nov 2019 22:30:03 +0100
MIME-Version: 1.0
In-Reply-To: <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
Content-Type: multipart/alternative;
 boundary="------------23FEA8AB7FB6243AF640709C"
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
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------23FEA8AB7FB6243AF640709C
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

I noticed that my last reply was not sent to the mailing list, so this 
is a duplicate of the reply I sent to Samuli Seppänen

Hi,

Thanks for your detailed instructions!

On 02-11-19 8:08, Samuli Seppänen wrote:
> Hi,
>
> Il 01/11/19 23:40, Ton van Vliet ha scritto:
>> Thanks for the info.
>>
>> A quick reply for now:
>>
>> On 01-11-19 19:28, Samuli Seppänen wrote:
>>> Hi,
>>>
>>> Il 01/11/19 18:58, Ton van Vliet ha scritto:
>>>> Hi,
>>>>
>>>> A sincere 'Thank You' to all developers for their continuous work done
>>>> on OpenVPN !
>>>>
>>>> Both the 2.4.8-I601-Win7 and 2.4.8-I602-Win7 executables fail with 'An
>>>> error occurred installing the TAP device drivers.'
>>> What operating system are you running exactly?
>> This installation is on Win7 Home Premium (SP1)
> Ok.
>
>>>> After running the 2.4.8 installer, all of my (named) TAP devices had
>>>> disappeared (I have more than one!)
>>>>
>>>> Reinstalling the previous 2.4.7-Win7 version (twice) brought them all
>>>> back to life again.
>>>>
>>>> Is there a way I can get more detailed information about what could be
>>>> causing this. It is the first time that I encounter this error.
>>> Yes there is:
>>>
>>> <https://community.openvpn.net/openvpn/wiki/ManagingWindowsTAPDrivers>
>>>
>>> In particular check C:\Windows\inf\setupapi.dev.log. It contains
>>> installation logs for Windows drivers in general, not just tap-windows6.
>>> It generally gives a pretty good idea of the problem. It should not have
>>> any sensitive information in it so you can post the relevant lines here.
>> In the relevant sections are quite a few error lines starting with '!',
>> but these are present in both the 2.4.7 and 2.4.8 install (most of them
>> are related to failing verification)
>>
>> Except for the following lines, which are only present in the 2.4.8 install
>>
>> !    dvi:                          Device 'ROOT\NET\0021' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0012' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0009' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0004' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0005' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0011' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0002' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>> !    dvi:                          Device 'ROOT\NET\0013' required
>> reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
>>
>> and the following line, which occurs multiple times (for each TAP device)
>>
>> !!!  dvi:                     Device not started: Device has problem:
>> 0x0a: CM_PROB_FAILED_START.
>>
>> Does that help, or is more information needed to get a clue?
> Hi,
>
> I've never seen this particular problem. I'm not sure what "Device <n>
> required reboot" means. Does it suggest rebooting the computer? Maybe
> worth a shot if you did not do it already.
>
> If reboot does not help I recommend wiping all traces of tap-windows6
> from the computer and then installing 2.4.8-I602-Win7. The process I use
> during testing is this:
>
> 1) Uninstall tap-windows6
> 2) Remove traces of tap-windows6 from driver store
>
>     Clone or download (as zip):
>
>     <https://github.com/mattock/tap-windows-scripts>
>
>     Launch a Powershell session as an Administrator. Then
>
>     cd tap-windows-scripts
>     ./Remove-Tapwindows.ps1
>
>     This will display you the tap-windows6 drivers it would remove from
>     the driver store, something like this:
>
>       Would remove oem<x>.inf
>       Would remove oem<y>.inf
>
>     In your case there would probably be many of these lines. They all
>     should start with "oem".
>
>     To actually remove the drivers add -Yes parameter:
>
>    ./Remove-Tapwindows.ps1 -Yes
>
>    After this there are no traces of tap-windows6 on your computer.
>
> 3) Install 2.4.8-I602-Win7 and see if the problem is gone
>
> --
>
> Let me know if this resolves the problem.

Following your instructions, I managed to remove all tap-windows6 
references.

Apart from the one that was in use, there were 2 other leftover 
oem<x>.inf files that showed up using your script, but which the script 
could not remove (not even with an added -f parameter) but after some 
digging into the registry and windows system folders I managed to get 
rid of these as well.

After that the installation ran flawlessly.

I have no idea why it went wrong this time, as I have been following 
along with all releases for several years without any hick-ups, however, 
as apparently I am the only one having this issue, I fully understand 
your (workaround) approach vector.

Thanks again.

-- 

Ton

>>> Samuli
>>>
>>>> -- 
>>>> Ton
>>>>
>>>> On 31-10-19 13:04, Samuli Seppänen wrote:
>>>>> Hi,
>>>>>
>>>>> We recently found out that the code signing certificate the 2.4.8
>>>>> Windows installers use expired a couple of weeks ago. I will get a new
>>>>> certificate today evening (~6 hours) and push out new installers.
>>>>>
>>>>> This problem only seems to affect the prompt you get when you
>>>>> double-click on the installer executable. You probably see "Unknown
>>>>> publisher" there. Besides that Windows seems to be perfectly happy with
>>>>> the executables and libraries. That is the main reason why a problem
>>>>> such as this was able to slip through testing.
>>>>>
>>>>> Samuli
>>>>>
>>>>> Il 31/10/19 12:27, Samuli Seppänen ha scritto:
>>>>>> The OpenVPN community project team is proud to release OpenVPN
>>>>>> 2.4.8. It
>>>>>> can be downloaded from here:
>>>>>>
>>>>>> <https://openvpn.net/community-downloads/>
>>>>>>
>>>>>> This is primarily a maintenance release with bugfixes and
>>>>>> improvements.
>>>>>> The Windows installers (I601) have several improvements compared to
>>>>>> the
>>>>>> previous release:
>>>>>>
>>>>>> * New tap-windows6 driver (9.24.2) which fixes some suspend and resume
>>>>>> issues
>>>>>> * Latest OpenVPN-GUI
>>>>>> * Considerable performance boost due to new compiler optimization
>>>>>> flags
>>>>>>
>>>>>> A summary of all included changes is available here:
>>>>>>
>>>>>> <https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>
>>>>>>
>>>>>> A full list of changes is available here:
>>>>>>
>>>>>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>>>>>>
>>>>>> Please note that LibreSSL is not a supported crypto backend. We accept
>>>>>> patches and we do test on OpenBSD 6.0 which comes with LibreSSL,
>>>>>> but if
>>>>>> newer versions of LibreSSL break API compatibility we do not take
>>>>>> responsibility to fix that.
>>>>>>
>>>>>> Also note that  Windows installers have been built with NSIS version
>>>>>> that has been patched against several NSIS installer code execution
>>>>>> and
>>>>>> privilege escalation problems:
>>>>>>
>>>>>> <https://community.openvpn.net/openvpn/wiki/NSISBug1125>
>>>>>>
>>>>>> Based on our testing, though, older Windows versions such as Windows 7
>>>>>> might not benefit from these fixes. We thus strongly encourage you to
>>>>>> always move NSIS installers to a non-user-writeable location before
>>>>>> running them. Our long-term plan is to migrate to using MSI installers
>>>>>> instead.
>>>>>>
>>>>>> Compared to OpenVPN 2.3 this is a major update with a large number of
>>>>>> new features, improvements and fixes. Some of the major features are
>>>>>> AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
>>>>>> IPv4/IPv6 dual stack support and more seamless connection migration
>>>>>> when
>>>>>> client's IP address changes (Peer-ID). Also, the new --tls-crypt
>>>>>> feature
>>>>>> can be used to increase users' connection privacy.
>>>>>>
>>>>>> OpenVPN GUI bundled with the Windows installer has a large number
>>>>>> of new
>>>>>> features compared to the one bundled with OpenVPN 2.3. One of major
>>>>>> features is the ability to run OpenVPN GUI without administrator
>>>>>> privileges.
>>>>>>
>>>>>> For full details, look here:
>>>>>>
>>>>>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>>>>>>
>>>>>> The new OpenVPN GUI features are documented here:
>>>>>>
>>>>>> <https://github.com/OpenVPN/openvpn-gui>
>>>>>>
>>>>>> Please note that OpenVPN 2.4 installers will not work on Windows XP.
>>>>>>
>>>>>> For generic help use these support channels:
>>>>>>
>>>>>> Official documentation:
>>>>>> <http://openvpn.net/index.php/open-source/documentation/howto.html>
>>>>>> Wiki: <https://community.openvpn.net>
>>>>>> Forums: <https://forums.openvpn.net>
>>>>>> User mailing list: <http://sourceforge.net/mail/?group_id=48978>
>>>>>> User IRC channel: #openvpn at irc.freenode.net
>>>>>>
>>>>>> Please report bugs and ask development questions here:
>>>>>>
>>>>>> Bug tracker and wiki: <https://community.openvpn.net>
>>>>>> Developer mailing list: <http://sourceforge.net/mail/?group_id=48978>
>>>>>> Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
>>>>>> Freenode registration)
>>>>>>
>>>>>>
>>>>>> Samuli
>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Openvpn-devel mailing list
>>>>>> Openvpn-devel@lists.sourceforge.net
>>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>>
>>>>> _______________________________________________
>>>>> Openvpn-devel mailing list
>>>>> Openvpn-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
>>>> _______________________________________________
>>>> Openvpn-devel mailing list
>>>> Openvpn-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
>


--------------23FEA8AB7FB6243AF640709C
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre><tt>I noticed that my last reply was not sent to the mailing list, so this is a duplicate of the reply I sent to Samuli Seppänen</tt></pre>
    <pre><tt>
Hi,
</tt></pre>
    <pre><tt>Thanks for your detailed instructions!
 </tt></pre>
    <tt>On 02-11-19 8:08, Samuli Seppänen wrote:</tt>
    <blockquote type="cite"
      cite="mid:7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...">
      <pre class="moz-quote-pre" wrap="">Hi,

Il 01/11/19 23:40, Ton van Vliet ha scritto:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Thanks for the info.

A quick reply for now:

On 01-11-19 19:28, Samuli Seppänen wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Hi,

Il 01/11/19 18:58, Ton van Vliet ha scritto:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Hi,

A sincere 'Thank You' to all developers for their continuous work done
on OpenVPN !

Both the 2.4.8-I601-Win7 and 2.4.8-I602-Win7 executables fail with 'An
error occurred installing the TAP device drivers.'
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">What operating system are you running exactly?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This installation is on Win7 Home Premium (SP1)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ok.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">After running the 2.4.8 installer, all of my (named) TAP devices had
disappeared (I have more than one!)

Reinstalling the previous 2.4.7-Win7 version (twice) brought them all
back to life again.

Is there a way I can get more detailed information about what could be
causing this. It is the first time that I encounter this error.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Yes there is:

<a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/ManagingWindowsTAPDrivers">&lt;https://community.openvpn.net/openvpn/wiki/ManagingWindowsTAPDrivers&gt;</a>

In particular check C:\Windows\inf\setupapi.dev.log. It contains
installation logs for Windows drivers in general, not just tap-windows6.
It generally gives a pretty good idea of the problem. It should not have
any sensitive information in it so you can post the relevant lines here.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
In the relevant sections are quite a few error lines starting with '!',
but these are present in both the 2.4.7 and 2.4.8 install (most of them
are related to failing verification)

Except for the following lines, which are only present in the 2.4.8 install

!    dvi:                          Device 'ROOT\NET\0021' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0012' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0009' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0004' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0005' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0011' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0002' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.
!    dvi:                          Device 'ROOT\NET\0013' required
reboot: Device has problem: 0x0a: CM_PROB_FAILED_START.

and the following line, which occurs multiple times (for each TAP device)

!!!  dvi:                     Device not started: Device has problem:
0x0a: CM_PROB_FAILED_START.

Does that help, or is more information needed to get a clue?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hi,

I've never seen this particular problem. I'm not sure what "Device &lt;n&gt;
required reboot" means. Does it suggest rebooting the computer? Maybe
worth a shot if you did not do it already.

If reboot does not help I recommend wiping all traces of tap-windows6
from the computer and then installing 2.4.8-I602-Win7. The process I use
during testing is this:

1) Uninstall tap-windows6
2) Remove traces of tap-windows6 from driver store

   Clone or download (as zip):

   <a class="moz-txt-link-rfc2396E" href="https://github.com/mattock/tap-windows-scripts">&lt;https://github.com/mattock/tap-windows-scripts&gt;</a>

   Launch a Powershell session as an Administrator. Then

   cd tap-windows-scripts
   ./Remove-Tapwindows.ps1

   This will display you the tap-windows6 drivers it would remove from
   the driver store, something like this:

     Would remove oem&lt;x&gt;.inf
     Would remove oem&lt;y&gt;.inf

   In your case there would probably be many of these lines. They all
   should start with "oem".

   To actually remove the drivers add -Yes parameter:

  ./Remove-Tapwindows.ps1 -Yes

  After this there are no traces of tap-windows6 on your computer.

3) Install 2.4.8-I602-Win7 and see if the problem is gone

--

Let me know if this resolves the problem.
</pre>
    </blockquote>
    <pre><tt>Following your instructions, I managed to remove all tap-windows6 
references.
</tt></pre>
    <pre><tt>Apart from the one that was in use, there were 2 other leftover 
oem&lt;x&gt;.inf files that showed up using your script, but which the script 
could not remove (not even with an added -f parameter) but after some 
digging into the registry and windows system folders I managed to get 
rid of these as well.
</tt></pre>
    <pre><tt>After that the installation ran flawlessly.
</tt></pre>
    <pre><tt>I have no idea why it went wrong this time, as I have been following 
along with all releases for several years without any hick-ups, however, 
as apparently I am the only one having this issue, I fully understand 
your (workaround) approach vector.
</tt></pre>
    <pre><tt>Thanks again.
</tt></pre>
    <pre><tt><span class="moz-txt-tag">-- </span></tt></pre>
    <pre class="moz-quote-pre" wrap=""><tt><span class="moz-txt-tag"></span></tt><tt>Ton
</tt>
</pre>
    <blockquote type="cite"
      cite="mid:7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Samuli

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">-- 
Ton

On 31-10-19 13:04, Samuli Seppänen wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Hi,

We recently found out that the code signing certificate the 2.4.8
Windows installers use expired a couple of weeks ago. I will get a new
certificate today evening (~6 hours) and push out new installers.

This problem only seems to affect the prompt you get when you
double-click on the installer executable. You probably see "Unknown
publisher" there. Besides that Windows seems to be perfectly happy with
the executables and libraries. That is the main reason why a problem
such as this was able to slip through testing.

Samuli

Il 31/10/19 12:27, Samuli Seppänen ha scritto:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">The OpenVPN community project team is proud to release OpenVPN
2.4.8. It
can be downloaded from here:

<a class="moz-txt-link-rfc2396E" href="https://openvpn.net/community-downloads/">&lt;https://openvpn.net/community-downloads/&gt;</a>

This is primarily a maintenance release with bugfixes and
improvements.
The Windows installers (I601) have several improvements compared to
the
previous release:

* New tap-windows6 driver (9.24.2) which fixes some suspend and resume
issues
* Latest OpenVPN-GUI
* Considerable performance boost due to new compiler optimization
flags

A summary of all included changes is available here:

<a class="moz-txt-link-rfc2396E" href="https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst">&lt;https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst&gt;</a>

A full list of changes is available here:

<a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24">&lt;https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24&gt;</a>

Please note that LibreSSL is not a supported crypto backend. We accept
patches and we do test on OpenBSD 6.0 which comes with LibreSSL,
but if
newer versions of LibreSSL break API compatibility we do not take
responsibility to fix that.

Also note that  Windows installers have been built with NSIS version
that has been patched against several NSIS installer code execution
and
privilege escalation problems:

<a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/NSISBug1125">&lt;https://community.openvpn.net/openvpn/wiki/NSISBug1125&gt;</a>

Based on our testing, though, older Windows versions such as Windows 7
might not benefit from these fixes. We thus strongly encourage you to
always move NSIS installers to a non-user-writeable location before
running them. Our long-term plan is to migrate to using MSI installers
instead.

Compared to OpenVPN 2.3 this is a major update with a large number of
new features, improvements and fixes. Some of the major features are
AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
IPv4/IPv6 dual stack support and more seamless connection migration
when
client's IP address changes (Peer-ID). Also, the new --tls-crypt
feature
can be used to increase users' connection privacy.

OpenVPN GUI bundled with the Windows installer has a large number
of new
features compared to the one bundled with OpenVPN 2.3. One of major
features is the ability to run OpenVPN GUI without administrator
privileges.

For full details, look here:

<a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24">&lt;https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24&gt;</a>

The new OpenVPN GUI features are documented here:

<a class="moz-txt-link-rfc2396E" href="https://github.com/OpenVPN/openvpn-gui">&lt;https://github.com/OpenVPN/openvpn-gui&gt;</a>

Please note that OpenVPN 2.4 installers will not work on Windows XP.

For generic help use these support channels:

Official documentation:
<a class="moz-txt-link-rfc2396E" href="http://openvpn.net/index.php/open-source/documentation/howto.html">&lt;http://openvpn.net/index.php/open-source/documentation/howto.html&gt;</a>
Wiki: <a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net">&lt;https://community.openvpn.net&gt;</a>
Forums: <a class="moz-txt-link-rfc2396E" href="https://forums.openvpn.net">&lt;https://forums.openvpn.net&gt;</a>
User mailing list: <a class="moz-txt-link-rfc2396E" href="http://sourceforge.net/mail/?group_id=48978">&lt;http://sourceforge.net/mail/?group_id=48978&gt;</a>
User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

Bug tracker and wiki: <a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net">&lt;https://community.openvpn.net&gt;</a>
Developer mailing list: <a class="moz-txt-link-rfc2396E" href="http://sourceforge.net/mail/?group_id=48978">&lt;http://sourceforge.net/mail/?group_id=48978&gt;</a>
Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
Freenode registration)


Samuli



_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>

</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">
_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">

_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------23FEA8AB7FB6243AF640709C--

