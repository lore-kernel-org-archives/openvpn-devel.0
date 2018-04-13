References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <20180412082603.GT69387@...1296...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <afa08ec6-eef6-c9f9-6c7e-af71ad069d48@...1918...>
Date: Fri, 13 Apr 2018 13:45:03 +1000
MIME-Version: 1.0
In-Reply-To: <20180412082603.GT69387@...1296...>
Content-Type: multipart/alternative;
 boundary="------------CD77C2073C6BD6DE0E695FEE"
Content-Language: en-US
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------CD77C2073C6BD6DE0E695FEE
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gert,

PR #47 has been submitted to tap-windows6 on github.

Regards,
Eric

--
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 12/04/2018 6:26 PM, Gert Doering wrote:
> Hi Eric,
>
> On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:
>> One of the Viscosity developers here. The TAP driver used by Viscosity
>> is based on the OpenVPN TAP-Windows driver. We're surprised to hear of
>> any performance differences, as the changes we've made are very minimal.
>>
>> Besides a name and version number change, the only other modification is
>> a change to the reported network adapter speed, which has Windows report
>> the driver as 1000 Mbit instead of 100 Mbit.
>>
>> This change was made not because of any actual performance gains, but
>> because of user reports that certain firewall or AV software tries to
>> QoS the adapter based on its reported adapter speed, which is of course
>> a problem if the VPN connection is capable of more than 100 Mbit.
>>
>> Please find a patch file of the changes attached.
> I think it would make sense for us to merge that patch - for two reasons,
> one is "the change could indeed help performance in high-bandwidth
> situtions", and the more important one is "another patch to tap-windows6
> is forthcoming, and that way we can keep the version numbers aligned
> so people can know what is inside".
>
> Do you have the patch in git?  If yes, could you please do the commit
> with "-s" (so the signed-off-by: line is added) and send it as regular
> git commit (git-send-email)?  Alternatively a PR against tap-windows6
> on github should do as well.
>
> Thanks in advance,
>
> gert
>



--------------CD77C2073C6BD6DE0E695FEE
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Gert,</p>
    <p>PR #47 has been submitted to tap-windows6 on github.<br>
    </p>
    <p>Regards,<br>
      Eric<br>
    </p>
    <pre class="moz-signature" cols="72">--
Eric Thorpe
SparkLabs Developer
<a class="moz-txt-link-freetext" href="https://www.sparklabs.com">https://www.sparklabs.com</a>
<a class="moz-txt-link-freetext" href="https://twitter.com/sparklabs">https://twitter.com/sparklabs</a>
<a class="moz-txt-link-abbreviated" href="mailto:support@...1918...">support@...1918...</a></pre>
    <div class="moz-cite-prefix">On 12/04/2018 6:26 PM, Gert Doering
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180412082603.GT69387@...1296..."
      id="mid_20180412082603_GT69387_greenie_muc_de" class=" cite">
      <pre wrap="">Hi Eric,

On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:
</pre>
      <blockquote type="cite" id="Cite_7807" class=" cite">
        <pre wrap="">One of the Viscosity developers here. The TAP driver used by Viscosity 
is based on the OpenVPN TAP-Windows driver. We're surprised to hear of 
any performance differences, as the changes we've made are very minimal.

Besides a name and version number change, the only other modification is 
a change to the reported network adapter speed, which has Windows report 
the driver as 1000 Mbit instead of 100 Mbit.

This change was made not because of any actual performance gains, but 
because of user reports that certain firewall or AV software tries to 
QoS the adapter based on its reported adapter speed, which is of course 
a problem if the VPN connection is capable of more than 100 Mbit.

Please find a patch file of the changes attached.
</pre>
      </blockquote>
      <pre wrap="">I think it would make sense for us to merge that patch - for two reasons,
one is "the change could indeed help performance in high-bandwidth
situtions", and the more important one is "another patch to tap-windows6
is forthcoming, and that way we can keep the version numbers aligned
so people can know what is inside".

Do you have the patch in git?  If yes, could you please do the commit
with "-s" (so the signed-off-by: line is added) and send it as regular
git commit (git-send-email)?  Alternatively a PR against tap-windows6
on github should do as well.

Thanks in advance,

gert

</pre>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------CD77C2073C6BD6DE0E695FEE--

