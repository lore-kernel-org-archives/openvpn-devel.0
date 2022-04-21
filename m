From: Heiko Hund <heiko@...2662...>
Date: Thu, 21 Apr 2022 14:45:58 +0200
Message-ID: <40260611.Av2MKxIUWH@...2664...>
In-Reply-To: <CAF465zq8R9fEXL+1PAO2-x48D6PPJt05WSe5KYSRukfT8NVtUg@...278...>
References: <20220420233148.2384208-1-heiko@...2662...>
 <YmESwwvWq/IwpMg+@greenie.muc.de>
 <CAF465zq8R9fEXL+1PAO2-x48D6PPJt05WSe5KYSRukfT8NVtUg@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add git pre-commit hook script to
 uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi David

On Donnerstag, 21. April 2022 13:41:58 CEST David Schneider wrote:
> Did you consider to use the pre-commit framework [1] written in
> Python? There is a maintained hook for uncrustify [2].
> This would allow it to easily integrate other linters/checks. See the
> list of supported hooks [3].

I stumbled across this, but it seemed too big for the purpose. Was looking for 
something small that could integrate into the dev-tools. That said, I don't 
think it holds anyone back from using the pre-commit stuff with the repo's 
uncrustify.conf. So, if you already do use it please feel free to add some 
short howto to the developer documentation (something I missed doing, but will 
add in v2).

Heiko



