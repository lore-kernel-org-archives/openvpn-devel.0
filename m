MIME-Version: 1.0
References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
 <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
 <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
 <20190420150719.GM31008@...1296...>
 <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>
 <CAPM6dUDJXL+Ncf3Fm2xW1rsf4ohYkzWMrhr8hJ9WraRQOtUHFw@...278...>
 <153a66cf-50dc-764c-b1be-ca471a27ac18@...1227...>
In-Reply-To: <153a66cf-50dc-764c-b1be-ca471a27ac18@...1227...>
From: wei wang <lnykww@...277...>
Date: Thu, 6 Jun 2019 17:34:28 +0800
Message-ID: <CAPM6dUAfb9mE7XX0zhDwThWLDmk_HMRgPWknbx2vFdOEm5=mrw@...278...>
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, Apr 23, 2019 at 7:30 PM Arne Schwabe <arne@...1227...> wrote:
>
> Am 23.04.19 um 05:01 schrieb wei wang:
> > 3. clean client connect defered ret file when close instance.
> >
>
> I agree that I missed a place in which I should cleaning up the temp
> file but adding it to close_instance seem more like a workaround than a
> real solution. Again describing more context would be nice here. What
> exactly is this trying to fix and why in this way.
>
> Arne
>
UPDATE the status for patch
("https://patchwork.openvpn.net/project/openvpn2/list/?series=3D413")=EF=BC=
=9A
We has run this patch for one month. and it works well.

--=20
Regards,
Wang Wei

