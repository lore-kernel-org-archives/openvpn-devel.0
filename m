MIME-Version: 1.0
References: <1600994969-7623-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1600994969-7623-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 25 Sep 2020 12:23:57 +0300
Message-ID: <CAGyAFMUivDd97TsJ4mFg1ktC_c1as-bD6n0CPGrTfA+qRDceKA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Set DNS Domain using iservice
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Note: this will set the domain twice if both v4 and v6 DNS
> servers are defined. It cant hurt, but could be avoided by
> making the domain setting a separate call from the DNS
> server setting.

I think we should do that - there is no reason to make expensive call twice:

$ time wmic nicconfig where \(InterfaceIndex=38\) call SetDNSDomain vpntest.lev
Executing (\\LAPTOP-4L3N7KFS\ROOT\CIMV2:Win32_NetworkAdapterConfiguration.Index=17)->SetDNSDomain()
Method execution successful.
Out Parameters:
instance of __PARAMETERS
{
        ReturnValue = 0;
};

real    0m0,236s
user    0m0,000s
sys     0m0,015s

Besides, DOMAIN could also be set by DHCP - there is no point
to do it via service in this case.

> +        strncpy(dns.domains, tt->options.domain, _countof(dns.domains));
> +       /* truncation of domain name is not checked as it cant happen
> +        * with 512 bytes room in dns.domains.
> +        */

Mix of tabs and whitespaces.

> +    /* comma separated list must be enclosed in parenthesis */

We don't pass lists yet, is this for future SearchDomains support?

> +    if (msg->domains[0]) {
> +        err = SetDNSDomain(wide_name, msg->domains, lists);
> +    }

msg->domains comes from (unprivileged) client and might
not be NULL terminated. Shall we do something like

    msg->domains[sizeof(msg->domains) - 1] = '\0';

Same for interface_t::name. Or am I missing something?

