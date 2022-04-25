Date: Mon, 25 Apr 2022 15:19:53 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1073556762.338511.1650892793663@...2642...>
In-Reply-To: <c03d612c-318d-297d-81cd-4b9b7d973d65@...1227...>
References: <20220422134038.3801239-4-arne@...1227...>
 <20220425122709.4148015-1-arne@...1227...>
 <1819498256.337104.1650892135929@...2642...>
 <c03d612c-318d-297d-81cd-4b9b7d973d65@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Move pre decrypt lite check to its
 own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net


Acked-By: Frank Lichtenheld <frank@...2641...>

> Arne Schwabe <arne@...1227...> hat am 25.04.2022 15:12 geschrieben:
> Am 25.04.22 um 15:08 schrieb Frank Lichtenheld:
[...]
> > You could replace four lines with one:
> > 
> > return tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf));
> > 
> > But that might not make sense due to changes in later patches? Haven't checked.
> > 
> 
> The function grows to a 70 line function over the course of the patches. :)

Fair enough. Acked.

Regards,
--
Frank Lichtenheld

