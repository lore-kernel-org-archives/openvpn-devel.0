MIME-Version: 1.0
References: <1561491241-16380-1-git-send-email-lstipakov@...277...>
 <20190625194905.GM1097@...1296...>
 <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
 <CAGyAFMWRqAhpsXaSPouXQPEzmCM5qDMD-Pie2XaqdXPL3weLMA@...278...>
 <CAKuzo_j7zdB6oeJ59NxFOKmZi6m9iyBq67cWMJFYt513mdXs_w@...278...>
In-Reply-To: <CAKuzo_j7zdB6oeJ59NxFOKmZi6m9iyBq67cWMJFYt513mdXs_w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Jun 2019 18:08:12 -0400
Message-ID: <CAKuzo_jvYaihBobd14U45epDOB43Dd_Kmhyug7py_+hmFjnCBg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service
 to open tun
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

What I have in mind would also require editing all calls
to send_msg_iservice() which is essentially what Gert is objecting to.
So ignore me -- a separate send_msg_iservice_ex may be the
best option.

Selva

On Tue, Jun 25, 2019 at 5:00 PM Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> On Tue, Jun 25, 2019 at 4:38 PM Lev Stipakov <lstipakov@...277...> wrote:
> >
> > Hi,
> >
> >>
> >> The way interactive service structures are coded should not require
> >> this at all, does it? The size and message type are already in the
> >> header, so why do we need to pass it?
> >
> >
> > But we need to know the response size in send_msg_iservice() since
> > we pass it to ReadFile(). So far we assumed that response is always ask_message_t
> > and we could do sizeof(*ack). With new response type this assumption doesn't hold so
> > as Gert suggested I added another version which accepts arbitrary response type and size.
>
> My point is that, this is not in the spirit of the rest of iservice code. See
> HandleMessage in interactive.c where the data is and then interpreted
> using the header type and size.
>
> For what max-size to pass to ReadFile, we know it from the size in the header
> element of the struct.
>
> Selva
>
>
> >
> > bool
> > send_msg_iservice(HANDLE pipe, const void *data, size_t size,
> >                   ack_message_t *ack, const char *context)
> > {
> >     return send_msg_iservice_ex(pipe, data, size, ack, sizeof(*ack), context);
> > }
> >
> > bool
> > send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
> >                      void *response, size_t response_size, const char *context)
> > {
> >
> > Will send V2 tomorrow with this and CreateFileW changes.
> >
> >
> > --
> > -Lev

