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
Date: Tue, 23 Apr 2019 20:22:32 +0800
Message-ID: <CAPM6dUBMu-JmFUz3EBWR9v27q1UqiH=HjkP=dL2KXRvq1ohQ1w@...278...>
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
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, Apr 23, 2019 at 7:30 PM Arne Schwabe <arne@...1227...> wrote:

> I agree that I missed a place in which I should cleaning up the temp
> file but adding it to close_instance seem more like a workaround than a
> real solution. Again describing more context would be nice here. What
> exactly is this trying to fix and why in this way.
>

Not only deferred ret file, but also config file. Here is just a description of
the need to clean up. I haven't thought of a specific fix, because I am not
very familiar with the openvpn code.

When the client connects to openvpn, and client-connect has not returned.
After a while, the same client reconnects to openvpn. At this time, the previous
openvpn connection(dup connection)  will be closed and multi_instance
was deleted,
and also the client-connect-script has not yet written back to
deferred-ret-file.
In this case, the file created by client-connect-deferred is leaked.




-- 
Regards,
Wang Wei

