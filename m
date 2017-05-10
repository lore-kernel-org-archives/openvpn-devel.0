References: <20170504173605.8269-1-valdikss@...277...>
	<CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...>
	<9cc5162b-d81b-9286-e715-e6c7d807385d@...277...>
	<CAKuzo_hw3A1tAmqq_OQWgnrEyn2FSB9_T1ME5+TnrDDmkv0eXg@...278...>
From: ValdikSS <valdikss@...277...>
Message-ID: <f2ca53fc-e01f-1e58-6342-9ec495494ea4@...277...>
Date: Wed, 10 May 2017 21:49:32 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hw3A1tAmqq_OQWgnrEyn2FSB9_T1ME5+TnrDDmkv0eXg@...278...>
Content-Type: multipart/alternative;
	boundary="------------7C8821A3A665D1754E0A0655"
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Set a low interface metric for tap
 adapter when block-outside-dns is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------7C8821A3A665D1754E0A0655
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Added it. Can't compile for 32 bit, I tried multiple times but can't wrestle down build system to compile my version from git. It never finds OpenSSL.
It successfully compiles for 64 bit.

Please check v2.

On 10.05.2017 19:40, Selva Nair wrote:
>
> On Wed, May 10, 2017 at 12:08 PM, ValdikSS <valdikss@...277... <mailto:valdikss@...277...>> wrote:
>
>
> In block-dns.c where "WFP-related defines and GUIDs not in mingw32" are defined, add this
>
> VOID NETIOAPI_API_
> InitializeIpInterfaceEntry(PMIB_IPINTERFACE_ROW Row );
>
> Do a test build for 32 bit to see now this function compiles without warnings
> and links without errors. 32 bit is a more stringent test because only in this
> case the linker will fail to find stdcall functions without proper declarations.
>
> That should be it.
>
> Selva
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------7C8821A3A665D1754E0A0655
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Added it. Can't compile for 32 bit, I tried multiple times but can't
    wrestle down build system to compile my version from git. It never
    finds OpenSSL.<br>
    It successfully compiles for 64 bit.<br>
    <br>
    Please check v2.<br>
    <br>
    <div class="moz-cite-prefix">On 10.05.2017 19:40, Selva Nair wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_hw3A1tAmqq_OQWgnrEyn2FSB9_T1ME5+TnrDDmkv0eXg@...278...">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Wed, May 10, 2017 at 12:08 PM,
            ValdikSS <span dir="ltr">&lt;<a
                href="mailto:valdikss@...277..." target="_blank"
                moz-do-not-send="true">valdikss@...277...</a>&gt;</span>
            wrote:<br>
          </div>
          <br>
          <br>
        </div>
        <div class="gmail_extra">In block-dns.c where "WFP-related
          defines and GUIDs not in mingw32" are defined, add this<br>
          <br>
          VOID NETIOAPI_API_ <br>
          InitializeIpInterfaceEntry(<wbr>PMIB_IPINTERFACE_ROW Row );<br>
          <br>
        </div>
        <div class="gmail_extra">Do a test build for 32 bit to see now
          this function compiles without warnings<br>
          and links without errors. 32 bit is a more stringent test
          because only in this<br>
          case the linker will fail to find stdcall functions without
          proper declarations.<br>
          <br>
        </div>
        <div class="gmail_extra">That should be it.<br>
          <br>
        </div>
        <div class="gmail_extra">Selva<br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class="moz-txt-link-freetext" href="http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------7C8821A3A665D1754E0A0655--

