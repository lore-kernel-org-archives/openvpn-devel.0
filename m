MIME-Version: 1.0
In-Reply-To: <20180312082122.GP69387@...1296...>
References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
 <20180312082122.GP69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 12 Mar 2018 10:37:53 -0400
Message-ID: <CAKuzo_hnjcLSAi0PxFUC+KxtahUAgdt_qRMKZJCsjvmT3WWLvQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip expired certificates in
 Windows certificate store
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Mar 12, 2018 at 4:21 AM, Gert Doering <gert@...1296...> wrote:
>
> Hi Selva,
>
> On Sun, Mar 11, 2018 at 09:17:58PM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Have the cryptoapicert option find the first matching certificate
> > in store that is valid at the present time. Currently the first
> > found item, even if expired, is returned.
>
> Are these two intended for master only or master+2.4?
>
> (I admit that I am too lazy right now to go and actually look at the
> surrounding code :-) - but with all the recent work wrt cryptoapi and
> external management key, I lost track which bits are considered "new
> goodies for master only")
>
> Functionality-wise this makes sense (feature-ACK), and it also makes
> sense for 2.4 - because "if there are two certificates, an expired and
> a valid one, and we take the expired one" smells very much like a bug
> to me :-)


Agree, this could qualify for 2.4. Anyway, the context is the same and
it applies/cherry-picks to 2.4 without issues.

Elsewhere in the code we only warn about expired certs (like those
read from a file) and continue with the connection to eventually end
up with the unhelpful "TLS key negotiation failed to complete. Check
your network..." error [*].  In that sense this is a regression. IMO, the client
should error out on invalid certs from other sources as well.

Selva

