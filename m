Message-ID: <54F8DA38.1090603@...1856...>
Date: Thu, 05 Mar 2015 23:35:36 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <20140827093409.GA659@...1900...>	<20150223155132.GA28440@...2018...>	<20150223161832.GN8134@...1296...>	<54EB5549.9050108@...1114...>	<54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
In-Reply-To: <CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
 5705]
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
To: daniel kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net


On 02-03-15 01:03, daniel kubec wrote:
> Greetings Steffan, David and Gert
>
> Thank you very much for your comments.
>
> 1) log level switched to D_TLS_DEBUG_MED
> 2) ekm_size removed, ekm_size != 0 condition is used instead.
> 3) changed to: exported_keying_material
> 4) minimum set to 16 bytes and maximum set to 4095 bytes.
>
> Added 2 patches related to [RFC-5705] (code + docs).

Thanks. This looks good, the extra file in doc/ helps.  Still a few 
remarks though.  Really really minor, but let's get it right anyway :)

+.B \-\-keying-material-exporter [label] [len] (min. 16)

I should have spotted this in an earlier patch, but I just noticed the 
brackets around label and len.  In the manpage such brackets indicate 
optional arguments, i.e. there should be no brackets in this case.

+      to.ekm_size = options->keying_material_exporter_length;
+      if (to.ekm_size < 16 || to.ekm_size > 4095)
+          to.ekm_size = 0;

vs

+      if (ekm_length < 16)
+        {
+          msg (msglevel, "Invalid keying material exporter length");
+          goto err;
+        }

Could you add the upper bound to the check in options.c too?

+channel bindings is straitforward and well-defined mechanism how to

That is spelled "straightforward".

I'll leave the assessment of the docs to Gert, as he can easier judge 
whether this is clear enough.

David, can you confirm the plugin aspects of this implementation are 
correct?

Apart from the remaining nits, ACK on the code.

-Steffan

