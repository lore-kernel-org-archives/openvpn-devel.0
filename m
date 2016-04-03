MIME-Version: 1.0
In-Reply-To: <57016640.1060208@...277...>
References: <57016640.1060208@...277...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 3 Apr 2016 17:10:51 -0400
Message-ID: <CAEsd45QUmZu35zushUaRF+OgnqQo7925Uc9e3X7dBFLBr-XDNg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/7] vlan: Add global,
 per-client 802.1q-based options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Mike Auty <mike.auty@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, Apr 3, 2016 at 2:51 PM, Mike Auty <mike.auty@...277...> wrote:
>
> This patch add the new global "--vlan-tagging" boolean switch.  This specifies
> whether openvpn should handle 802.1q tagged packets in any way.
>
> This patch also adds the new global '--vlan-accept tagged|untagged|all' which
> specifies the behaviour of the tap device with regards to 802.1q vlan tagged
> packets.
>
> This patch also adds the new "--vlan-pvid" integer option.


<snip>

> @@ -7178,6 +7224,45 @@ add_option (struct options *options,
>        options->keying_material_exporter_length = ekm_length;
>      }
>  #endif
> +#ifdef ENABLE_VLAN_TAGGING
> +  else if (streq (p[0], "vlan-tagging"))
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      options->vlan_tagging = true;
> +    }
> +  else if (streq (p[0], "vlan-accept") && p[1])
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      if (streq (p[1], "tagged"))
> +       {
> +         options->vlan_accept = VAF_ONLY_VLAN_TAGGED;
> +       }
> +      else if (streq (p[1], "untagged"))
> +       {
> +         options->vlan_accept = VAF_ONLY_UNTAGGED_OR_PRIORITY;
> +       }
> +      else if (streq (p[1], "all"))
> +       {
> +         options->vlan_accept = VAF_ALL;
> +       }
> +      else
> +       {
> +         msg (msglevel, "--vlan-accept must be 'tagged', 'untagged' or 'all'");
> +         goto err;
> +       }
> +    }
> +  else if (streq (p[0], "vlan-pvid") && p[1])
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
> +      options->vlan_pvid = positive_atoi (p[1]);
> +      if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
> +         options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
> +       {
> +         msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %u and <= %u", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
> +         goto err;
> +       }
> +    }
> +#endif
>    else
>      {
>        int i;


NAK. This should include testing for extra parameters supplied in
error with the options, as the rest of the option-handling code does.
Something like the following (for each of the three new options):

+  else if (streq (p[0], "vlan-tagging") && !p[1])

