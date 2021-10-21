References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-4-arne@...1227...>
 <CAKuzo_jOdVxYE4OOA+cjXCpi0PkgQqt_WHGtZT0X0vdAkJ7MXw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <110a6779-421f-6fe3-d1d5-530658e45555@...1227...>
Date: Thu, 21 Oct 2021 11:42:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jOdVxYE4OOA+cjXCpi0PkgQqt_WHGtZT0X0vdAkJ7MXw@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 03/21] [OSSL 3.0] Implement DES ECB
 encrypt via EVP_CIPHER api
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
> 
> Apart from the wrong cipher type that Max pointed out, this call will
> fail in OpenSSL 3.0 unless legacy is loaded, right? Causing a run-time
> error in that case sounds good to me but a helpful error message like
> legacy provider may be required or even a check whether legacy is loaded
> and error out appropriately would be helpful.
> 
> PS: can't we just get rid of the use of DES altogether?
> 

As Gert pointed out that NTLM depends on it. We can trick a bit here
with DES-EDE and three times the same key but yes it should have a
better error message.

Arne

