References: <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
Date: Tue, 30 Jun 2020 16:15:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200630141103.GY1431@...1296...>
Content-Type: multipart/alternative;
 boundary="------------6FCBEF9D16625321F6DD870B"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------6FCBEF9D16625321F6DD870B
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

hi,

On 30/06/20 16:11, Gert Doering wrote:
> Hi,
>
> On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
>> @@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
>>       write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
>>       write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
>>   
>> +    for (int i=0; i < o->domain_search_list_len; i++)
>> +    {
>> +        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &error);
>> +    }
> I assume that this won't work.  In the DHCP answer, it must be a single
> option with the concatenated list, not multiple answers with a single
> domain name each.
>
> gert
>
see https://tools.ietf.org/html/rfc3397

"

    In the above diagram, Searchstring is a string specifying the
    searchlist.  If the length of the searchlist exceeds the maximum
    permissible within a single option (255 octets), then multiple
    options MAY be used, as described in "Encoding Long Options in the
    Dynamic Host Configuration Protocol (DHCPv4)" [RFC3396 <https://tools.ietf.org/html/rfc3396>].

"


so you MAY use this option multiple times - and wireshark groks it fine. I don't have a Windows 10
client to test it against, however, so I am hoping that someone (Selva?) can do that for me.

cheers,

JJK


--------------6FCBEF9D16625321F6DD870B
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">hi,<br>
      <br>
      On 30/06/20 16:11, Gert Doering wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200630141103.GY1431@...1296...">
      <pre wrap="">Hi,

On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">@@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
     write_dhcp_u32_array(buf, 42, (uint32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;error);
     write_dhcp_u32_array(buf, 45, (uint32_t *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;error);
 
+    for (int i=0; i &lt; o-&gt;domain_search_list_len; i++)
+    {
+        write_dhcp_search_str(buf, 119, o-&gt;domain_search_list[i], &amp;error);
+    }
</pre>
      </blockquote>
      <pre wrap="">
I assume that this won't work.  In the DHCP answer, it must be a single 
option with the concatenated list, not multiple answers with a single 
domain name each.

gert

</pre>
    </blockquote>
    see <a class="moz-txt-link-freetext" href="https://tools.ietf.org/html/rfc3397">https://tools.ietf.org/html/rfc3397</a><br>
    <br>
    "<br>
    <pre class="newpage">   In the above diagram, Searchstring is a string specifying the
   searchlist.  If the length of the searchlist exceeds the maximum
   permissible within a single option (255 octets), then multiple
   options MAY be used, as described in "Encoding Long Options in the
   Dynamic Host Configuration Protocol (DHCPv4)" [<a href="https://tools.ietf.org/html/rfc3396" title="&quot;Encoding Long Options in the Dynamic Host Configuration Protocol (DHCPv4)&quot;">RFC3396</a>].

"


so you MAY use this option multiple times - and wireshark groks it fine. I don't have a Windows 10 
client to test it against, however, so I am hoping that someone (Selva?) can do that for me.

cheers,

JJK

</pre>
  </body>
</html>

--------------6FCBEF9D16625321F6DD870B--

