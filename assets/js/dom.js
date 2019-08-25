
// Builds a new activity into the DOM
export function addActivityToTop(activity) {
  const wrapper = document.createElement('div')
  wrapper.classList.add('activity-wrapper')

  const main = document.createElement('span')
  main.classList.add('activity-wrapper__main')
  main.innerText = activity.what

  const time = document.createElement('span')
  time.classList.add('activity-wrapper__time')
  time.innerText = new Date(activity.occurred_at).toLocaleString()

  const tier = document.createElement('span')
  tier.classList.add('activity-wrapper__tier', `activity-wrapper__tier--${activity.customer_tier}`)
  tier.innerText = activity.customer_tier

  wrapper.appendChild(main)
  wrapper.appendChild(time)
  wrapper.appendChild(tier)

  document.getElementById('activity-container').prepend(wrapper)
}
