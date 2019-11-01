References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
From: Ton van Vliet <epposan@...277...>
Message-ID: <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
Date: Fri, 1 Nov 2019 17:58:56 +0100
MIME-Version: 1.0
In-Reply-To: <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
Content-Type: multipart/alternative;
 boundary="------------6A7454A54EED611B15E670DC"
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
--------------6A7454A54EED611B15E670DC
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi,

A sincere 'Thank You' to all developers for their continuous work done 
on OpenVPN !

Both the 2.4.8-I601-Win7 and 2.4.8-I602-Win7 executables fail with 'An 
error occurred installing the TAP device drivers.'

After running the 2.4.8 installer, all of my (named) TAP devices had 
disappeared (I have more than one!)

Reinstalling the previous 2.4.7-Win7 version (twice) brought them all 
back to life again.

Is there a way I can get more detailed information about what could be 
causing this. It is the first time that I encounter this error.

-- 
Ton

On 31-10-19 13:04, Samuli Seppänen wrote:
> Hi,
>
> We recently found out that the code signing certificate the 2.4.8
> Windows installers use expired a couple of weeks ago. I will get a new
> certificate today evening (~6 hours) and push out new installers.
>
> This problem only seems to affect the prompt you get when you
> double-click on the installer executable. You probably see "Unknown
> publisher" there. Besides that Windows seems to be perfectly happy with
> the executables and libraries. That is the main reason why a problem
> such as this was able to slip through testing.
>
> Samuli
>
> Il 31/10/19 12:27, Samuli Seppänen ha scritto:
>> The OpenVPN community project team is proud to release OpenVPN 2.4.8. It
>> can be downloaded from here:
>>
>> <https://openvpn.net/community-downloads/>
>>
>> This is primarily a maintenance release with bugfixes and improvements.
>> The Windows installers (I601) have several improvements compared to the
>> previous release:
>>
>> * New tap-windows6 driver (9.24.2) which fixes some suspend and resume
>> issues
>> * Latest OpenVPN-GUI
>> * Considerable performance boost due to new compiler optimization flags
>>
>> A summary of all included changes is available here:
>>
>> <https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>
>>
>> A full list of changes is available here:
>>
>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>>
>> Please note that LibreSSL is not a supported crypto backend. We accept
>> patches and we do test on OpenBSD 6.0 which comes with LibreSSL, but if
>> newer versions of LibreSSL break API compatibility we do not take
>> responsibility to fix that.
>>
>> Also note that  Windows installers have been built with NSIS version
>> that has been patched against several NSIS installer code execution and
>> privilege escalation problems:
>>
>> <https://community.openvpn.net/openvpn/wiki/NSISBug1125>
>>
>> Based on our testing, though, older Windows versions such as Windows 7
>> might not benefit from these fixes. We thus strongly encourage you to
>> always move NSIS installers to a non-user-writeable location before
>> running them. Our long-term plan is to migrate to using MSI installers
>> instead.
>>
>> Compared to OpenVPN 2.3 this is a major update with a large number of
>> new features, improvements and fixes. Some of the major features are
>> AEAD (GCM) cipher and Elliptic Curve DH key exchange support, improved
>> IPv4/IPv6 dual stack support and more seamless connection migration when
>> client's IP address changes (Peer-ID). Also, the new --tls-crypt feature
>> can be used to increase users' connection privacy.
>>
>> OpenVPN GUI bundled with the Windows installer has a large number of new
>> features compared to the one bundled with OpenVPN 2.3. One of major
>> features is the ability to run OpenVPN GUI without administrator privileges.
>>
>> For full details, look here:
>>
>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24>
>>
>> The new OpenVPN GUI features are documented here:
>>
>> <https://github.com/OpenVPN/openvpn-gui>
>>
>> Please note that OpenVPN 2.4 installers will not work on Windows XP.
>>
>> For generic help use these support channels:
>>
>> Official documentation:
>> <http://openvpn.net/index.php/open-source/documentation/howto.html>
>> Wiki: <https://community.openvpn.net>
>> Forums: <https://forums.openvpn.net>
>> User mailing list: <http://sourceforge.net/mail/?group_id=48978>
>> User IRC channel: #openvpn at irc.freenode.net
>>
>> Please report bugs and ask development questions here:
>>
>> Bug tracker and wiki: <https://community.openvpn.net>
>> Developer mailing list: <http://sourceforge.net/mail/?group_id=48978>
>> Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
>> Freenode registration)
>>
>>
>> Samuli
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------6A7454A54EED611B15E670DC
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi,<br>
    <br>
    A sincere 'Thank You' to all developers for their continuous work
    done on OpenVPN !<br>
    <br>
    Both the 2.4.8-I601-Win7 and 2.4.8-I602-Win7 executables fail with
    'An error occurred installing the TAP device drivers.'<br>
    <br>
    After running the 2.4.8 installer, all of my (named) TAP devices had
    disappeared (I have more than one!)<br>
    <br>
    Reinstalling the previous 2.4.7-Win7 version (twice) brought them
    all back to life again.<br>
    <br>
    Is there a way I can get more detailed information about what could
    be causing this. It is the first time that I encounter this error.<br>
    <br>
    --  <br>
    Ton<br>
    <br>
    <div class="moz-cite-prefix">On 31-10-19 13:04, Samuli Seppänen
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d34d5974-30ac-6949-9be4-7f4a55126564@...515...">
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
        <pre class="moz-quote-pre" wrap="">The OpenVPN community project team is proud to release OpenVPN 2.4.8. It
can be downloaded from here:

<a class="moz-txt-link-rfc2396E" href="https://openvpn.net/community-downloads/">&lt;https://openvpn.net/community-downloads/&gt;</a>

This is primarily a maintenance release with bugfixes and improvements.
The Windows installers (I601) have several improvements compared to the
previous release:

* New tap-windows6 driver (9.24.2) which fixes some suspend and resume
issues
* Latest OpenVPN-GUI
* Considerable performance boost due to new compiler optimization flags

A summary of all included changes is available here:

<a class="moz-txt-link-rfc2396E" href="https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst">&lt;https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst&gt;</a>

A full list of changes is available here:

<a class="moz-txt-link-rfc2396E" href="https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24">&lt;https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn24&gt;</a>

Please note that LibreSSL is not a supported crypto backend. We accept
patches and we do test on OpenBSD 6.0 which comes with LibreSSL, but if
newer versions of LibreSSL break API compatibility we do not take
responsibility to fix that.

Also note that  Windows installers have been built with NSIS version
that has been patched against several NSIS installer code execution and
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
IPv4/IPv6 dual stack support and more seamless connection migration when
client's IP address changes (Peer-ID). Also, the new --tls-crypt feature
can be used to increase users' connection privacy.

OpenVPN GUI bundled with the Windows installer has a large number of new
features compared to the one bundled with OpenVPN 2.3. One of major
features is the ability to run OpenVPN GUI without administrator privileges.

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

--------------6A7454A54EED611B15E670DC--

