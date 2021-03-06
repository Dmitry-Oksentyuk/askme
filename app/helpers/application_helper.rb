# В этом файле мы можем писать вспомогательные методы (хелперы)
# для представлений (view) нашего приложения
module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть
  # Или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def user_color(user)
    if user.color.present?
      user.color
    else
      user.color = 0
    end
  end


  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  #метод склонятор, выводит существительные в нужном падеже
  def sklonyator(number, krokodil, krokodila, krokodilov)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    ostatok = number % 10
    ostatok_2 = number % 100

    if ostatok_2 >= 11 && ostatok_2 <= 14
      return krokodilov
    elsif ostatok == 1
      return krokodil
    elsif ostatok >= 2 && ostatok <= 4
      return krokodila
    elsif ostatok == 0 ||ostatok > 4
      return krokodilov
    end
  end
end
