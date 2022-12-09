From: "Vladislav Grishenko" <themiron@...2010...>
References: <20221122183706.12561-1-gert@...1296...>
 <20221130205718.79765-1-gert@...1296...>
 <Y4i0JBNkm0/77lzt@...2685...>
In-Reply-To: <Y4i0JBNkm0/77lzt@...2685...>
Date: Fri, 9 Dec 2022 23:19:14 +0500
Message-ID: <030e01d90bfa$bec96720$3c5c3560$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v14] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Frank Lichtenheld' <frank@...2641...>, 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Frank,

> > +    "--remote-srv domain [service] : Perform DNS SRV remote host
> discovery.\n"
> 
> Missing [proto]

Sure, will add

> > -    if (!proto_is_udp(ce->proto) && options->mtu_test)
> > +    /* Defer validation for --remote-srv with auto protocol */
> > +    if (!proto_is_udp(ce->proto) && options->mtu_test
> > +        && !(ce->remote_srv && ce->proto == PROTO_AUTO))
> >      {
> >          msg(M_USAGE, "--mtu-test only makes sense with --proto udp");
> 
> You disable this test here, but you don't add this in any of the
> later checks. So it seems this test is just completely removed when
> using remote-srv?

Right, this check should be moved into options_postprocess_verify_ce_proto()
and seems forgotten, will add it too. Thank you

> > + * get_cached_srv_entry return 0 on success and -1
> 
> "returns"

Ok, sure

--
Best Regards, Vladislav Grishenko



