Message-Id: <200303120205.h2C25r405986@...41...>
Subject: Re: [Openvpn-devel] [PATCH]: add config-variables to OpenVPN-1.3.2
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030311203318.200ff724.zls@...76...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Mar 11 18:07:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lademann@...76..., ZLS Software GmbH <510047448921-0001@...75...>, openvpn-devel@lists.sourceforge.net

Christian,

Rather than put a lot of scripting language infrastructure into OpenVPN's
config file parser, why not just use a shell script, i.e.:

  openvpn --dev-name vpn_${CUSTNO} \
          --port     5${CUSTNO} \
          --ifconfig 10.0.0.1 10.0.${CUSTNO}.1 \
          --dev-type tun \
          [ ... ]

After all, isn't this exactly the sort of problem that shell scripting
languages were supposed to solve?

James

ZLS Software GmbH <510047448921-0001@...75...> said:

> Hi, Jim,
> 
> here is another one:
> 
> I've added variable-expandion to config-values and the keywords "set" and
"unset".
> With this technique you can easily split configuration of one peer across
two files:
> one with the specific and one with the common config values in a way that
can help to
> minimize the number of "configuration-knobs". 
> 
> 
> An example:
> 
>         /etc/openvpn/customer_123.conf:
> 
>         # specific configuration for customer #123
> 	set CUSTNO 123
>         config ./customers.common
> 
> 
>         /etc/openvpn/customer.common:
> 
>         # meta-configuration for all customers
>         dev-name vpn_$(CUSTNO)             # vpn_001 to vpn_255
>         port     5$(CUSTNO)                # 5001 to 5255
>         ifconfig 10.0.0.1 10.0.$(CUSTNO).1 # 10.0.001.1 to 10.0.255.1
>         dev-type tun                       # other stuff ...
>            .
>            .
>            .
> 
> These are the same variable-expansion routines I committed to the Snort-IDS
some time ago.
> 
> The syntax is  follows:
> 
>     set name value    define the variable "name" containing "value".
>     unset name        undefine the variable "name".
> 
>     $(name)           replace with the contents of variable "name".
> 
>     $(name:-default)  replace with the contents of the variable "name" or with
>                       "default" if "name" is undefined.
> 
>     $(name:?message)  replace with the contents of variable "name" or print out
>                       the error message "message" and exit.
> 
> 
> The next thing could be something like $(( expression or calculation )).
> 
> As before, the patch is quite young and certanly needs more testing :-)
> 
> 
> Regards,
> 
> Christian Lademann <lademann@...76...>
> 
> -- 
> *  Christian A. Lademann, ZLS Software GmbH          mailto:lademann@...76...
> *  ZLS Software GmbH
> *  Frankfurter Strasse 59       Postfach 1628             mailto:zls@...76...
> *  D-65779 Kelkheim             D-65766 Kelkheim          http://www.zls.de
> *  Telefon +49-6195-9902-0      Telefax +49-6195-900600
> 
> 
> 



-- 




